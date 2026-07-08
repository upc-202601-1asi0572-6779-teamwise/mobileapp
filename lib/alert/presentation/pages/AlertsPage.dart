import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_alert_row.dart';
import '../providers/AlertProvider.dart';
import '../../domain/entities/AlertEntity.dart';

class AlertsPage extends StatefulWidget {
  const AlertsPage({super.key});

  @override
  State<AlertsPage> createState() => _AlertsPageState();
}

class _AlertsPageState extends State<AlertsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AlertProvider>().loadAlerts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AlertProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: Column(children: [
        _AlertsHeader(
          selectedFilter: provider.selectedFilter,
          onFilterChanged: provider.setFilter,
        ),
        Expanded(
          child: switch (provider.status) {
            AlertStatus.loading => const Center(
                child: CircularProgressIndicator(color: SPColors.primary)),
            AlertStatus.error =>
                Center(child: Text(provider.errorMessage, style: SPType.body)),
            AlertStatus.loaded =>
                _AlertsList(alerts: provider.filteredAlerts),
            _ => const SizedBox.shrink(),
          },
        ),
      ]),
    );
  }
}

class _AlertsHeader extends StatelessWidget {
  final String selectedFilter;
  final void Function(String) onFilterChanged;
  const _AlertsHeader(
      {required this.selectedFilter, required this.onFilterChanged});

  @override
  Widget build(BuildContext context) {
    const tabs = <(String, String)>[
      ('todas', 'Todas'),
      ('criticas', 'Críticas'),
      ('advertencia', 'Advertencia'),
    ];
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
          SPSpacing.xl, SPSpacing.x6l, SPSpacing.xl, SPSpacing.lg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Alertas', style: SPType.hero.copyWith(color: Colors.white)),
        const SizedBox(height: 14),
        Container(
          decoration: BoxDecoration(
            color: const Color(0x1FFFFFFF),
            borderRadius: BorderRadius.circular(100),
          ),
          padding: const EdgeInsets.all(4),
          child: Row(
            children: tabs.map<Widget>((tab) {
              final id = tab.$1;
              final label = tab.$2;
              final active = selectedFilter == id;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onFilterChanged(id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: active ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      label,
                      style: SPType.caption.copyWith(
                        fontWeight: FontWeight.w500,
                        color: active
                            ? SPColors.primaryDark
                            : const Color(0xCCFFFFFF),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ]),
    );
  }
}

class _AlertsList extends StatelessWidget {
  final List<AlertEntity> alerts;
  const _AlertsList({required this.alerts});

  @override
  Widget build(BuildContext context) {
    if (alerts.isEmpty) {
      return Center(
        child: Text('No hay alertas en esta categoría',
            style: SPType.body.copyWith(color: SPColors.muted)),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(SPSpacing.lg),
      itemCount: alerts.length,
      itemBuilder: (_, i) {
        final a = alerts[i];
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SPCard(
            margin: EdgeInsets.zero,
            child: SPAlertRow(
              level: SPAlertTokens.fromString(a.level),
              title: a.title,
              subtitle: a.block ?? '',
              time: a.timeAgo,
              showDivider: false,
            ),
          ),
        );
      },
    );
  }
}
