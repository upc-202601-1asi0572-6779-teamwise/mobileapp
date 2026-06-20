import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_chip.dart';
import '../providers/SensorProvider.dart';
import '../../domain/entities/SensorEntity.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({super.key});

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SensorProvider>().loadSensors();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SensorProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: Column(children: [
        _SensorsHeader(
          activeCount: provider.activeCount,
          offlineCount: provider.offlineCount,
        ),
        Expanded(
          child: switch (provider.status) {
            SensorStatus.loading => const Center(
                child: CircularProgressIndicator(color: SPColors.primary)),
            SensorStatus.error =>
              Center(child: Text(provider.errorMessage, style: SPType.body)),
            SensorStatus.loaded =>
              _SensorList(sensors: provider.sensors),
            _ => const SizedBox.shrink(),
          },
        ),
      ]),
    );
  }
}

class _SensorsHeader extends StatelessWidget {
  final int activeCount, offlineCount;
  const _SensorsHeader(
      {required this.activeCount, required this.offlineCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
          SPSpacing.xl, SPSpacing.x6l, SPSpacing.xl, SPSpacing.x2l),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Sensores IoT', style: SPType.hero.copyWith(color: Colors.white)),
        const SizedBox(height: 4),
        Text('Red LoRaWAN · Fundo Las Palmas',
            style: SPType.caption.copyWith(color: const Color(0x99FFFFFF))),
        const SizedBox(height: 14),
        Row(children: [
          _StatBadge(
            label: '$activeCount activos',
            bg: const Color(0x2922C55E),
            border: const Color(0x4D22C55E),
            color: const Color(0xFF86EFAC),
          ),
          const SizedBox(width: 10),
          _StatBadge(
            label: '$offlineCount sin señal',
            bg: const Color(0x26EF4444),
            border: const Color(0x4DEF4444),
            color: const Color(0xFFFCA5A5),
          ),
        ]),
      ]),
    );
  }
}

class _StatBadge extends StatelessWidget {
  final String label;
  final Color bg, border, color;
  const _StatBadge(
      {required this.label, required this.bg,
       required this.border, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: SPType.tag.copyWith(color: color, fontWeight: FontWeight.w600)),
    );
  }
}

class _SensorList extends StatelessWidget {
  final List<SensorEntity> sensors;
  const _SensorList({required this.sensors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(SPSpacing.lg),
      itemCount: sensors.length + 1,
      itemBuilder: (_, i) {
        if (i == sensors.length) return const SizedBox(height: 60);
        return _SensorCard(sensor: sensors[i]);
      },
    );
  }
}

class _SensorCard extends StatelessWidget {
  final SensorEntity sensor;
  const _SensorCard({required this.sensor});

  @override
  Widget build(BuildContext context) {
    final batColor = batteryColor(sensor.batteryLevel);
    return SPCard(
      padding: const EdgeInsets.all(SPSpacing.m),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(sensor.id,
                  style: SPType.cardTitle.copyWith(
                      fontSize: 15, color: SPColors.text)),
              const SizedBox(height: 2),
              Text('${sensor.block} · ping: ${sensor.lastPing}',
                  style: SPType.caption.copyWith(color: SPColors.muted)),
            ]),
            SPStatusChip.fromString(sensor.status),
          ],
        ),
        const SizedBox(height: 10),
        Row(children: [
          Icon(Icons.battery_std, size: 16, color: batColor),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: sensor.batteryLevel / 100,
                minHeight: 4,
                backgroundColor: batColor.withOpacity(0.15),
                valueColor: AlwaysStoppedAnimation(batColor),
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 34,
            child: Text('${sensor.batteryLevel}%',
                style: SPType.tag.copyWith(color: batColor)),
          ),
        ]),
      ]),
    );
  }
}
