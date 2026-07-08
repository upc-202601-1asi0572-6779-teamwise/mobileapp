import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_header.dart';
import '../../../../widgets/sp_card.dart';
import '../providers/ReportProvider.dart';
import '../../domain/entities/ReportEntity.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ReportProvider>().loadReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ReportProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: Column(children: [
        const SPHeader(
          title: 'Reportes',
          subtitle: 'Exporta y comparte datos',
        ),
        Expanded(
          child: switch (provider.status) {
            ReportStatus.loading => const Center(
                child: CircularProgressIndicator(color: SPColors.primary)),
            ReportStatus.error =>
                Center(child: Text(provider.errorMessage, style: SPType.body)),
            ReportStatus.loaded =>
                _ReportsBody(reports: provider.reports, provider: provider),
            _ => const SizedBox.shrink(),
          },
        ),
      ]),
    );
  }
}

class _ReportsBody extends StatelessWidget {
  final List<ReportEntity> reports;
  final ReportProvider provider;
  const _ReportsBody({required this.reports, required this.provider});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(SPSpacing.lg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        _GenerateCard(provider: provider),
        const SizedBox(height: SPSpacing.lg),
        Text('Reportes recientes',
            style: SPType.sectionHeading.copyWith(color: SPColors.text)),
        const SizedBox(height: 10),
        SPCard(
          child: Column(
            children: List.generate(reports.length, (i) =>
                _ReportRow(report: reports[i],
                    showDivider: i < reports.length - 1)),
          ),
        ),
        const SizedBox(height: 60),
      ]),
    );
  }
}

class _GenerateCard extends StatelessWidget {
  final ReportProvider provider;
  const _GenerateCard({required this.provider});

  @override
  Widget build(BuildContext context) {
    const options = <(IconData, String, ReportType)>[
      (Icons.home_outlined, 'Reporte semanal', ReportType.weekly),
      (Icons.calendar_month_outlined, 'Reporte mensual', ReportType.monthly),
      (Icons.map_outlined, 'Por bloque específico', ReportType.byBlock),
    ];
    return SPCard(
      padding: const EdgeInsets.all(SPSpacing.lg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Generar nuevo reporte',
            style: SPType.sectionHeading.copyWith(color: SPColors.text)),
        const SizedBox(height: 12),
        ...options.map((opt) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: _GenerateOption(
            icon: opt.$1,
            label: opt.$2,
            isGenerating: provider.generateStatus == GenerateStatus.generating,
            onTap: () => provider.generateReport(opt.$3),
          ),
        )),
      ]),
    );
  }
}

class _GenerateOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isGenerating;
  final VoidCallback onTap;
  const _GenerateOption(
      {required this.icon, required this.label,
        required this.isGenerating, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isGenerating ? null : onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: SPSpacing.m, vertical: 11),
        decoration: BoxDecoration(
          color: SPColors.bg,
          border: Border.all(color: const Color(0xFFD1FAE5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: SPColors.softGreen,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: SPColors.primaryDark, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
              child: Text(label,
                  style: SPType.body.copyWith(
                      fontWeight: FontWeight.w500, color: SPColors.text))),
          if (isGenerating)
            const SizedBox(width: 18, height: 18,
                child: CircularProgressIndicator(strokeWidth: 2, color: SPColors.primary))
          else
            const Icon(Icons.chevron_right, color: SPColors.muted, size: 16),
        ]),
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  final ReportEntity report;
  final bool showDivider;
  const _ReportRow({required this.report, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    final isPdf = report.type == 'PDF';
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: SPSpacing.lg, vertical: 13),
        child: Row(children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: isPdf
                  ? const Color(0xFFFEF2F2)
                  : const Color(0xFFEFF6FF),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              report.type,
              style: SPType.tag.copyWith(
                color: isPdf
                    ? SPColors.crit
                    : const Color(0xFF3B82F6),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(report.name,
                      style: SPType.body.copyWith(
                          fontWeight: FontWeight.w500, color: SPColors.text)),
                  Text('${report.subtitle} · ${report.createdAgo}',
                      style: SPType.caption.copyWith(color: SPColors.muted)),
                ]),
          ),
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFF0FDF4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.download, color: SPColors.primary, size: 18),
          ),
        ]),
      ),
      if (showDivider)
        const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
    ]);
  }
}
