import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_alert_row.dart';
import '../../../auth/presentation/providers/AuthProvider.dart';
import '../../../core/providers/NavigationProvider.dart';
import '../../../gateway/presentation/providers/GatewayProvider.dart' as gw;
import '../../../plantation/domain/entities/PlantationEntity.dart';
import '../../../plantation/presentation/providers/PlantationProvider.dart' as pl;
import '../../../../alert/domain/entities/AlertEntity.dart';
import '../../../../alert/presentation/providers/AlertProvider.dart' as al;

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final gatewayProvider = context.watch<gw.GatewayProvider>();
    final plantationProvider = context.watch<pl.PlantationProvider>();
    final alertProvider = context.watch<al.AlertProvider>();

    final displayName = (auth.fullName != null && auth.fullName!.trim().isNotEmpty)
        ? auth.fullName!.split(' ').first
        : (auth.username ?? '');
    final anyGatewayConnected = gatewayProvider.gateways.any((g) => g.isConnected);
    final recentAlerts = alertProvider.status == al.AlertStatus.loaded
        ? alertProvider.filteredAlerts.take(3).toList()
        : <AlertEntity>[];
    final hasCritical = recentAlerts.any((a) => a.level == 'crit');
    final recentPlantations = plantationProvider.plantationsStatus == pl.LoadStatus.loaded
        ? plantationProvider.plantations.take(2).toList()
        : <PlantationEntity>[];

    return ColoredBox(
      color: SPColors.bg,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(displayName: displayName, isOnline: anyGatewayConnected),
            if (hasCritical)
              _CriticalBanner(alert: recentAlerts.firstWhere((a) => a.level == 'crit')),
            SPSectionHeader(
              title: 'Mis Parcelas',
              actionLabel: 'Ver todas',
              onAction: () => context.read<NavigationProvider>().switchTab(1),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SPSpacing.lg),
              child: recentPlantations.isEmpty
                  ? const _NoDataCard()
                  : Row(
                      children: recentPlantations.map((p) {
                        final isLast = p == recentPlantations.last;
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: isLast ? 0 : 8),
                            child: _PlotMiniCard(plantation: p),
                          ),
                        );
                      }).toList(),
                    ),
            ),
            SPSectionHeader(
              title: 'Alertas recientes',
              actionLabel: 'Ver todas',
              onAction: () => context.read<NavigationProvider>().switchTab(2),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SPSpacing.lg),
              child: recentAlerts.isEmpty
                  ? const _NoDataCard()
                  : SPCard(
                      child: SPAlertList(
                        alerts: recentAlerts.map((a) => (
                          level: SPAlertTokens.fromString(a.level),
                          title: a.title,
                          subtitle: a.block ?? '',
                          time: a.timeAgo,
                        )).toList(),
                      ),
                    ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String displayName;
  final bool isOnline;
  const _Header({required this.displayName, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
          SPSpacing.xl, SPSpacing.x6l, SPSpacing.xl, SPSpacing.x2l),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_OnlineBadge(isOnline: isOnline)],
          ),
          const SizedBox(height: 4),
          Text(
            'Buenos días, $displayName',
            style: SPType.hero.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class _OnlineBadge extends StatelessWidget {
  final bool isOnline;
  const _OnlineBadge({required this.isOnline});

  @override
  Widget build(BuildContext context) {
    final color = isOnline ? SPColors.primary : SPColors.muted;
    final label = isOnline ? 'Dispositivos en línea' : 'Sin conexión';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.35)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 6, height: 6,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label,
            style: SPType.tag.copyWith(color: color, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}

class _NoDataCard extends StatelessWidget {
  const _NoDataCard();

  @override
  Widget build(BuildContext context) {
    return SPCard(
      padding: const EdgeInsets.symmetric(vertical: SPSpacing.x2l, horizontal: SPSpacing.lg),
      child: Center(
        child: Text('No hay datos registrados aún',
            style: SPType.body.copyWith(color: SPColors.muted)),
      ),
    );
  }
}

class _CriticalBanner extends StatelessWidget {
  final AlertEntity alert;
  const _CriticalBanner({required this.alert});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(SPSpacing.lg, 14, SPSpacing.lg, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2),
        border: Border.all(color: const Color(0xFFFECACA)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        Container(
          width: 36, height: 36,
          decoration: BoxDecoration(
            color: SPColors.crit,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.warning_rounded, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Alerta crítica — acción requerida',
                style: SPType.body.copyWith(
                    fontWeight: FontWeight.w600, color: const Color(0xFF991B1B))),
            Text(alert.title,
                style: SPType.caption.copyWith(color: const Color(0xFFB91C1C))),
          ]),
        ),
        const Icon(Icons.chevron_right, color: SPColors.crit, size: 18),
      ]),
    );
  }
}

class _PlotMiniCard extends StatelessWidget {
  final PlantationEntity plantation;
  const _PlotMiniCard({required this.plantation});

  @override
  Widget build(BuildContext context) {
    return SPCard(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(plantation.name,
            style: SPType.cardTitle.copyWith(color: SPColors.text)),
        const SizedBox(height: 4),
        Text('${plantation.hectares.toInt()} ha',
            style: SPType.caption.copyWith(color: SPColors.muted)),
        const SizedBox(height: 8),
        Text(plantation.status,
            style: SPType.caption.copyWith(color: SPColors.primaryDark, fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
