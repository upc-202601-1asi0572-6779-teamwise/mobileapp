import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../domain/entities/IotDeviceEntity.dart';
import '../providers/GatewayProvider.dart';
import 'DeviceReadingsPage.dart';

class GatewayDetailPage extends StatefulWidget {
  final String gatewayMac;
  const GatewayDetailPage({super.key, required this.gatewayMac});

  @override
  State<GatewayDetailPage> createState() => _GatewayDetailPageState();
}

class _GatewayDetailPageState extends State<GatewayDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GatewayProvider>().loadDevices(widget.gatewayMac);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GatewayProvider>();
    return Scaffold(
      backgroundColor: SPColors.bg,
      appBar: AppBar(
        title: Text(widget.gatewayMac, style: const TextStyle(fontSize: 18)),
      ),
      body: switch (provider.devicesStatus) {
        LoadStatus.loading =>
          const Center(child: CircularProgressIndicator(color: SPColors.primary)),
        LoadStatus.error => Center(
            child: Padding(
              padding: const EdgeInsets.all(SPSpacing.x3l),
              child: Text(provider.devicesError,
                  style: SPType.body, textAlign: TextAlign.center),
            ),
          ),
        LoadStatus.loaded => provider.devices.isEmpty
            ? const _EmptyDevices()
            : _DeviceList(devices: provider.devices),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _EmptyDevices extends StatelessWidget {
  const _EmptyDevices();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SPSpacing.x3l),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.sensors_off_outlined, size: 48, color: SPColors.muted),
          const SizedBox(height: SPSpacing.lg),
          Text('Este gateway aún no tiene dispositivos IoT registrados',
              style: SPType.body.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _DeviceList extends StatelessWidget {
  final List<IotDeviceEntity> devices;
  const _DeviceList({required this.devices});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(SPSpacing.lg),
      itemCount: devices.length + 1,
      itemBuilder: (_, i) {
        if (i == devices.length) return const SizedBox(height: 60);
        return _DeviceCard(device: devices[i]);
      },
    );
  }
}

class _DeviceCard extends StatelessWidget {
  final IotDeviceEntity device;
  const _DeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return SPCard(
      padding: const EdgeInsets.all(SPSpacing.m),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DeviceReadingsPage(deviceMac: device.deviceMac),
        ));
      },
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: SPColors.primary.withOpacity(0.12),
            borderRadius: SPRadius.badgeRadius,
          ),
          child: const Icon(Icons.sensors_outlined, color: SPColors.primary),
        ),
        const SizedBox(width: SPSpacing.md),
        Expanded(
          child: Text(device.deviceMac,
              style: SPType.cardTitle.copyWith(fontSize: 15, color: SPColors.text)),
        ),
        const Icon(Icons.chevron_right, color: SPColors.muted),
      ]),
    );
  }
}
