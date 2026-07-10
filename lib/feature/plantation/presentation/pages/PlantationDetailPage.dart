import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_chip.dart';
import '../../../gateway/presentation/pages/DeviceReadingsPage.dart';
import '../../domain/entities/SectorEntity.dart';
import '../providers/PlantationProvider.dart';

class PlantationDetailPage extends StatefulWidget {
  final int plantationId;
  const PlantationDetailPage({super.key, required this.plantationId});

  @override
  State<PlantationDetailPage> createState() => _PlantationDetailPageState();
}

class _PlantationDetailPageState extends State<PlantationDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlantationProvider>().loadDetail(widget.plantationId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlantationProvider>();
    final detail = provider.detail;
    return Scaffold(
      backgroundColor: SPColors.bg,
      appBar: AppBar(
        title: Text(detail?.name ?? '', style: const TextStyle(fontSize: 18)),
      ),
      body: switch (provider.detailStatus) {
        LoadStatus.loading =>
          const Center(child: CircularProgressIndicator(color: SPColors.primary)),
        LoadStatus.error => Center(
            child: Padding(
              padding: const EdgeInsets.all(SPSpacing.x3l),
              child: Text(provider.detailError,
                  style: SPType.body, textAlign: TextAlign.center),
            ),
          ),
        LoadStatus.loaded => (detail == null || detail.sectors.isEmpty)
            ? const _EmptySectors()
            : _SectorList(sectors: detail.sectors),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _EmptySectors extends StatelessWidget {
  const _EmptySectors();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SPSpacing.x3l),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.sensors_off_outlined, size: 48, color: SPColors.muted),
          const SizedBox(height: SPSpacing.lg),
          Text('No hay datos registrados aún',
              style: SPType.body.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _SectorList extends StatelessWidget {
  final List<SectorEntity> sectors;
  const _SectorList({required this.sectors});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(SPSpacing.lg),
      itemCount: sectors.length + 1,
      itemBuilder: (_, i) {
        if (i == sectors.length) return const SizedBox(height: 60);
        return _SectorCard(sector: sectors[i]);
      },
    );
  }
}

class _SectorCard extends StatelessWidget {
  final SectorEntity sector;
  const _SectorCard({required this.sector});

  @override
  Widget build(BuildContext context) {
    final color = sector.status == 'Active' ? SPColors.ok : SPColors.muted;
    return SPCard(
      padding: const EdgeInsets.all(SPSpacing.m),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DeviceReadingsPage(deviceMac: sector.iotDeviceMacAddress),
        ));
      },
      child: Row(children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: SPRadius.badgeRadius,
          ),
          child: Icon(Icons.sensors_outlined, color: color),
        ),
        const SizedBox(width: SPSpacing.md),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(sector.name,
                style: SPType.cardTitle.copyWith(fontSize: 15, color: SPColors.text)),
            const SizedBox(height: 2),
            Row(children: [
              SPStatusDot(color: color),
              const SizedBox(width: 6),
              Text(sector.iotDeviceMacAddress,
                  style: SPType.caption.copyWith(color: SPColors.muted)),
            ]),
          ]),
        ),
        const Icon(Icons.chevron_right, color: SPColors.muted),
      ]),
    );
  }
}
