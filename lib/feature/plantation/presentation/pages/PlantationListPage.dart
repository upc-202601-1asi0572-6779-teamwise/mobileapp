import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../domain/entities/PlantationEntity.dart';
import '../providers/PlantationProvider.dart';
import 'PlantationDetailPage.dart';

class PlantationListPage extends StatefulWidget {
  const PlantationListPage({super.key});

  @override
  State<PlantationListPage> createState() => _PlantationListPageState();
}

class _PlantationListPageState extends State<PlantationListPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlantationProvider>().loadPlantations();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PlantationProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: Column(children: [
        const _PlantationsHeader(),
        Expanded(
          child: switch (provider.plantationsStatus) {
            LoadStatus.loading =>
              const Center(child: CircularProgressIndicator(color: SPColors.primary)),
            LoadStatus.error => Center(
                child: Padding(
                  padding: const EdgeInsets.all(SPSpacing.x3l),
                  child: Text(provider.plantationsError,
                      style: SPType.body, textAlign: TextAlign.center),
                ),
              ),
            LoadStatus.loaded => provider.plantations.isEmpty
                ? const _EmptyState()
                : _PlantationList(plantations: provider.plantations),
            _ => const SizedBox.shrink(),
          },
        ),
      ]),
    );
  }
}

class _PlantationsHeader extends StatelessWidget {
  const _PlantationsHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
          SPSpacing.xl, SPSpacing.x6l, SPSpacing.xl, SPSpacing.x2l),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mis Parcelas', style: SPType.hero.copyWith(color: Colors.white)),
        const SizedBox(height: 4),
        Text('Cultivos asignados a tu cuenta',
            style: SPType.caption.copyWith(color: const Color(0x99FFFFFF))),
      ]),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SPSpacing.x3l),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.grid_view_outlined, size: 48, color: SPColors.muted),
          const SizedBox(height: SPSpacing.lg),
          Text('No hay datos registrados aún',
              style: SPType.body.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
          const SizedBox(height: SPSpacing.xs),
          Text('El administrador de tu cultivo debe asignarte una parcela.',
              style: SPType.caption.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _PlantationList extends StatelessWidget {
  final List<PlantationEntity> plantations;
  const _PlantationList({required this.plantations});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(SPSpacing.lg),
      itemCount: plantations.length + 1,
      itemBuilder: (_, i) {
        if (i == plantations.length) return const SizedBox(height: 60);
        return _PlantationCard(plantation: plantations[i]);
      },
    );
  }
}

class _PlantationCard extends StatelessWidget {
  final PlantationEntity plantation;
  const _PlantationCard({required this.plantation});

  @override
  Widget build(BuildContext context) {
    final color = plantation.status == 'Active' ? SPColors.ok : SPColors.warn;
    return SPCard(
      padding: const EdgeInsets.all(SPSpacing.m),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => PlantationDetailPage(plantationId: plantation.id),
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
          child: Icon(Icons.grid_view_outlined, color: color),
        ),
        const SizedBox(width: SPSpacing.md),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(plantation.name,
                style: SPType.cardTitle.copyWith(fontSize: 15, color: SPColors.text)),
            const SizedBox(height: 2),
            Text('${plantation.hectares} ha · ${plantation.address}',
                style: SPType.caption.copyWith(color: SPColors.muted)),
          ]),
        ),
        const Icon(Icons.chevron_right, color: SPColors.muted),
      ]),
    );
  }
}
