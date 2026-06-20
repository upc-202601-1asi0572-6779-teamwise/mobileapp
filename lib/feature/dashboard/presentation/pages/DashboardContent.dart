import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_chip.dart';
import '../../../../widgets/sp_alert_row.dart';
import '../../../core/providers/NavigationProvider.dart';
import '../providers/DashboardProvider.dart';
import '../../domain/entities/DashboardSummaryEntity.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().loadDashboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DashboardProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: switch (provider.status) {
        DashboardStatus.loading => const Center(
            child: CircularProgressIndicator(color: SPColors.primary)),
        DashboardStatus.error => Center(
            child: Text(provider.errorMessage, style: SPType.body)),
        DashboardStatus.loaded => _DashboardBody(summary: provider.summary!),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _DashboardBody extends StatelessWidget {
  final DashboardSummaryEntity summary;
  const _DashboardBody({required this.summary});

  @override
  Widget build(BuildContext context) {
    final hasCritical = summary.recentAlerts.any((a) => a.level == 'crit');
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(summary: summary),
          if (hasCritical)
            _CriticalBanner(
              alert: summary.recentAlerts.firstWhere((a) => a.level == 'crit'),
            ),
          SPSectionHeader(
            title: 'Mis Parcelas',
            actionLabel: 'Ver todas',
            onAction: () => context.read<NavigationProvider>().switchTab(1),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SPSpacing.lg),
            child: Row(
              children: summary.recentPlots.take(2).map((p) {
                final isLast = p == summary.recentPlots.take(2).last;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: isLast ? 0 : 8),
                    child: _PlotMiniCard(plot: p),
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
            child: SPCard(
              child: SPAlertList(
                alerts: summary.recentAlerts.take(3).map((a) => (
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
    );
  }
}

class _Header extends StatelessWidget {
  final DashboardSummaryEntity summary;
  const _Header({required this.summary});

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                summary.location,
                style: SPType.caption.copyWith(color: const Color(0xA6FFFFFF)),
              ),
              _OnlineBadge(isOnline: summary.isOnline),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Buenos días, ${summary.farmerName} ☀️',
            style: SPType.hero.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 2),
          Text(
            summary.farmName,
            style: SPType.bodySmall.copyWith(color: const Color(0x99FFFFFF)),
          ),
          const SizedBox(height: SPSpacing.lg),
          Row(
            children: [
              _MetricChip(label: 'Humedad',
                  value: '${summary.humidity.toInt()}%',
                  color: SPColors.teal),
              const SizedBox(width: 8),
              _MetricChip(label: 'Temp',
                  value: '${summary.temperature.toInt()}°C',
                  color: SPColors.amber),
              const SizedBox(width: 8),
              _MetricChip(label: 'pH suelo',
                  value: summary.phSoil.toStringAsFixed(1),
                  color: SPColors.primary),
            ],
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
    final label = isOnline ? 'En línea' : 'Sin conexión';
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

class _MetricChip extends StatelessWidget {
  final String label, value;
  final Color color;
  const _MetricChip({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0x1AFFFFFF),
          border: Border.all(color: const Color(0x24FFFFFF)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label,
              style: SPType.caption.copyWith(color: const Color(0x80FFFFFF))),
          const SizedBox(height: 2),
          Text(value,
              style: SPType.metricValue.copyWith(color: color, fontSize: 18)),
        ]),
      ),
    );
  }
}

class _CriticalBanner extends StatelessWidget {
  final AlertSummaryEntity alert;
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
  final PlotSummaryEntity plot;
  const _PlotMiniCard({required this.plot});

  @override
  Widget build(BuildContext context) {
    return SPCard(
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(plot.name,
            style: SPType.cardTitle.copyWith(color: SPColors.text)),
        const SizedBox(height: 4),
        Text('${plot.hectares.toInt()} ha · ${plot.nodes} nodos',
            style: SPType.caption.copyWith(color: SPColors.muted)),
        const SizedBox(height: 8),
        SPStatusChip.fromString(plot.status),
      ]),
    );
  }
}
