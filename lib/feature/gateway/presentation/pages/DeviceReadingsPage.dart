import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../domain/entities/SensorReadingEntity.dart';
import '../providers/GatewayProvider.dart';

class DeviceReadingsPage extends StatefulWidget {
  final String deviceMac;
  const DeviceReadingsPage({super.key, required this.deviceMac});

  @override
  State<DeviceReadingsPage> createState() => _DeviceReadingsPageState();
}

class _DeviceReadingsPageState extends State<DeviceReadingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GatewayProvider>().loadReadings(widget.deviceMac);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GatewayProvider>();
    return Scaffold(
      backgroundColor: SPColors.bg,
      appBar: AppBar(
        title: Text(widget.deviceMac, style: const TextStyle(fontSize: 18)),
      ),
      body: switch (provider.readingsStatus) {
        LoadStatus.loading =>
          const Center(child: CircularProgressIndicator(color: SPColors.primary)),
        LoadStatus.error => Center(
            child: Padding(
              padding: const EdgeInsets.all(SPSpacing.x3l),
              child: Text(provider.readingsError,
                  style: SPType.body, textAlign: TextAlign.center),
            ),
          ),
        LoadStatus.loaded => provider.readings.isEmpty
            ? const _EmptyReadings()
            : _ReadingsView(readings: provider.readings),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _EmptyReadings extends StatelessWidget {
  const _EmptyReadings();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SPSpacing.x3l),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.show_chart, size: 48, color: SPColors.muted),
          const SizedBox(height: SPSpacing.lg),
          Text('Este dispositivo aún no ha enviado lecturas',
              style: SPType.body.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _ReadingsView extends StatelessWidget {
  final List<SensorReadingEntity> readings;
  const _ReadingsView({required this.readings});

  // readings ya viene ordenado por measuredAt descendente (GatewayProvider)
  Map<String, SensorReadingEntity> get _latestByType {
    final map = <String, SensorReadingEntity>{};
    for (final r in readings) {
      map.putIfAbsent(r.sensorType, () => r);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final latest = _latestByType;
    return ListView(
      padding: const EdgeInsets.all(SPSpacing.lg),
      children: [
        Text('Últimas lecturas', style: SPType.sectionHeading.copyWith(color: SPColors.text)),
        const SizedBox(height: SPSpacing.md),
        Wrap(
          spacing: SPSpacing.md,
          runSpacing: SPSpacing.md,
          children: latest.values.map((r) => _LatestReadingCard(reading: r)).toList(),
        ),
        const SizedBox(height: SPSpacing.x3l),
        Text('Historial', style: SPType.sectionHeading.copyWith(color: SPColors.text)),
        const SizedBox(height: SPSpacing.md),
        ...readings.map((r) => _ReadingRow(reading: r)),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _LatestReadingCard extends StatelessWidget {
  final SensorReadingEntity reading;
  const _LatestReadingCard({required this.reading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: SPCard(
        padding: const EdgeInsets.all(SPSpacing.m),
        margin: EdgeInsets.zero,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(_sensorLabel(reading.sensorType),
              style: SPType.caption.copyWith(color: SPColors.muted)),
          const SizedBox(height: 4),
          Text('${reading.value.toStringAsFixed(1)} ${_unitLabel(reading.unit, reading.sensorType)}',
              style: SPType.metricValue.copyWith(color: SPColors.primaryDark, fontSize: 22)),
        ]),
      ),
    );
  }
}

class _ReadingRow extends StatelessWidget {
  final SensorReadingEntity reading;
  const _ReadingRow({required this.reading});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('dd/MM HH:mm');
    return SPCard(
      padding: const EdgeInsets.symmetric(horizontal: SPSpacing.m, vertical: SPSpacing.sm),
      child: Row(children: [
        Expanded(
          flex: 2,
          child: Text(_sensorLabel(reading.sensorType), style: SPType.body),
        ),
        Expanded(
          child: Text('${reading.value.toStringAsFixed(1)} ${_unitLabel(reading.unit, reading.sensorType)}',
              style: SPType.body.copyWith(fontWeight: FontWeight.bold, color: SPColors.text)),
        ),
        Text(formatter.format(reading.measuredAt.toLocal()),
            style: SPType.caption.copyWith(color: SPColors.muted)),
      ]),
    );
  }
}

String _sensorLabel(String sensorType) => switch (sensorType) {
      'Temperature' => 'Temperatura',
      'Humidity' => 'Humedad ambiental',
      'SoilMoisture' => 'Humedad de suelo',
      'Luminosity' => 'Luminosidad',
      _ => sensorType,
    };

String _unitLabel(String unit, String sensorType) {
  if (unit != 'Unknown' && unit.isNotEmpty) return unit;
  return switch (sensorType) {
    'Temperature' => '°C',
    'Humidity' || 'SoilMoisture' => '%',
    'Luminosity' => 'lux',
    _ => '',
  };
}
