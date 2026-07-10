import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_chip.dart';
import '../../domain/entities/EdgeGatewayEntity.dart';
import '../providers/GatewayProvider.dart';
import 'GatewayDetailPage.dart';

class GatewayListPage extends StatefulWidget {
  const GatewayListPage({super.key});

  @override
  State<GatewayListPage> createState() => _GatewayListPageState();
}

class _GatewayListPageState extends State<GatewayListPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GatewayProvider>().loadGateways();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GatewayProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: Column(children: [
        const _GatewaysHeader(),
        Expanded(
          child: switch (provider.gatewaysStatus) {
            LoadStatus.loading => const Center(
                child: CircularProgressIndicator(color: SPColors.primary)),
            LoadStatus.error => Center(
                child: Padding(
                  padding: const EdgeInsets.all(SPSpacing.x3l),
                  child: Text(provider.gatewaysError,
                      style: SPType.body, textAlign: TextAlign.center),
                ),
              ),
            LoadStatus.loaded => provider.gateways.isEmpty
                ? const _EmptyState()
                : _GatewayList(gateways: provider.gateways),
            _ => const SizedBox.shrink(),
          },
        ),
      ]),
    );
  }
}

class _GatewaysHeader extends StatelessWidget {
  const _GatewaysHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
          SPSpacing.xl, SPSpacing.x6l, SPSpacing.xl, SPSpacing.x2l),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Mis Edge Gateways', style: SPType.hero.copyWith(color: Colors.white)),
        const SizedBox(height: 4),
        Text('Dispositivos asignados a tu cuenta',
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
          const Icon(Icons.router_outlined, size: 48, color: SPColors.muted),
          const SizedBox(height: SPSpacing.lg),
          Text('Aún no tienes edge gateways asignados',
              style: SPType.body.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
          const SizedBox(height: SPSpacing.xs),
          Text('El administrador de tu cultivo debe asignarte uno.',
              style: SPType.caption.copyWith(color: SPColors.muted),
              textAlign: TextAlign.center),
        ]),
      ),
    );
  }
}

class _GatewayList extends StatelessWidget {
  final List<EdgeGatewayEntity> gateways;
  const _GatewayList({required this.gateways});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(SPSpacing.lg),
      itemCount: gateways.length + 1,
      itemBuilder: (_, i) {
        if (i == gateways.length) return const SizedBox(height: 60);
        return _GatewayCard(gateway: gateways[i]);
      },
    );
  }
}

class _GatewayCard extends StatelessWidget {
  final EdgeGatewayEntity gateway;
  const _GatewayCard({required this.gateway});

  @override
  Widget build(BuildContext context) {
    final color = gateway.isConnected ? SPColors.ok : SPColors.crit;
    return SPCard(
      padding: const EdgeInsets.all(SPSpacing.m),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GatewayDetailPage(gatewayMac: gateway.mac),
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
          child: Icon(Icons.router_outlined, color: color),
        ),
        const SizedBox(width: SPSpacing.md),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(gateway.mac,
                style: SPType.cardTitle.copyWith(fontSize: 15, color: SPColors.text)),
            const SizedBox(height: 2),
            Row(children: [
              SPStatusDot(color: color),
              const SizedBox(width: 6),
              Text(gateway.status, style: SPType.caption.copyWith(color: SPColors.muted)),
            ]),
          ]),
        ),
        const Icon(Icons.chevron_right, color: SPColors.muted),
      ]),
    );
  }
}
