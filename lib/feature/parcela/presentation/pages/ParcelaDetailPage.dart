import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_header.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_chip.dart';
import '../providers/ParcelaDetailProvider.dart';
import '../../domain/entities/ParcelaDetailEntity.dart';

class ParcelaDetailPage extends StatefulWidget {
  final int parcelaId;
  const ParcelaDetailPage({super.key, required this.parcelaId});

  @override
  State<ParcelaDetailPage> createState() => _ParcelaDetailPageState();
}

class _ParcelaDetailPageState extends State<ParcelaDetailPage> {
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
    final provider = context.watch<ParcelaDetailProvider>();
    return Scaffold(
      backgroundColor: SPColors.bg,
      body: switch (provider.status) {
        ParcelaDetailStatus.loading => const Center(
            child: CircularProgressIndicator(color: SPColors.primary)),
        ParcelaDetailStatus.error =>
            Center(child: Text(provider.errorMessage, style: SPType.body)),
        ParcelaDetailStatus.loaded =>
            _DetailBody(entity: provider.detail!),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _DetailBody extends StatelessWidget {
  final ParcelaDetailEntity entity;
  const _DetailBody({required this.entity});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SPHeader(
          title: entity.name,
          subtitle:
          '${entity.hectares.toInt()} ha · ${entity.nodes} nodos · ${entity.location}',
          showBack: true,
          action: SPStatusChip.fromString(entity.status),
        ),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(SPSpacing.lg),
            child: Column(children: [
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.2,
                children: [
                  _MetricCard(label: 'Humedad',
                      value: entity.humidity.toInt().toString(),
                      unit: '%',
                      color: SPColors.teal,
                      pct: entity.humidity / 100),
                  _MetricCard(label: 'Temperatura',
                      value: entity.temperature.toInt().toString(),
                      unit: '°C',
                      color: SPColors.amber,
                      pct: entity.temperature / 50),
                  _MetricCard(label: 'pH del suelo',
                      value: entity.phSoil.toStringAsFixed(1),
                      unit: 'pH',
                      color: SPColors.primary,
                      pct: entity.phSoil / 14),
                  _MetricCard(label: 'Luz solar',
                      value: entity.solarLux.toInt().toString(),
                      unit: 'lx',
                      color: const Color(0xFFEAB308),
                      pct: (entity.solarLux / 1500).clamp(0, 1)),
                ],
              ),
              const SizedBox(height: 14),
              SPCard(
                padding: const EdgeInsets.all(SPSpacing.lg),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Historial · últimas 24 h',
                              style: SPType.sectionHeading
                                  .copyWith(color: SPColors.text)),
                          Text('Humedad',
                              style: SPType.body.copyWith(
                                  color: SPColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 80,
                        child: _HumidityChart(history: entity.humidityHistory),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: ['00:00', '06:00', '12:00', '18:00', 'Ahora']
                            .map((t) => Text(t,
                            style: SPType.caption
                                .copyWith(color: SPColors.muted)))
                            .toList(),
                      ),
                    ]),
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: SPSpacing.m, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFECFDF5),
                  border: Border.all(color: const Color(0xFFA7F3D0)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(children: [
                  Container(
                    width: 26, height: 26,
                    decoration: BoxDecoration(
                        color: SPColors.primary, shape: BoxShape.circle),
                    child: const Icon(Icons.check, color: Colors.white, size: 14),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Última sincronización: ${entity.lastSync} · ${entity.nodes} nodos OK',
                      style: SPType.bodySmall.copyWith(
                          color: SPColors.primaryDark,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ]),
              ),
              const SizedBox(height: 24),
            ]),
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String label, value, unit;
  final Color color;
  final double pct;
  const _MetricCard(
      {required this.label, required this.value, required this.unit,
        required this.color, required this.pct});

  @override
  Widget build(BuildContext context) {
    return SPCard(
      margin: EdgeInsets.zero,
      padding: const EdgeInsets.all(14),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label.toUpperCase(),
            style: SPType.eyebrow.copyWith(color: SPColors.muted)),
        const SizedBox(height: 8),
        Row(crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(value, style: SPType.metricValue.copyWith(color: SPColors.text)),
              const SizedBox(width: 3),
              Text(unit, style: SPType.bodySmall.copyWith(color: SPColors.muted)),
            ]),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: pct,
            minHeight: 4,
            backgroundColor: color.withOpacity(0.22),
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ]),
    );
  }
}

class _HumidityChart extends StatelessWidget {
  final List<double> history;
  const _HumidityChart({required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) return const SizedBox.shrink();
    final spots = List.generate(
        history.length, (i) => FlSpot(i.toDouble(), history[i]));
    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: const FlTitlesData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: SPColors.teal,
            barWidth: 2.5,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  SPColors.teal.withOpacity(0.25),
                  SPColors.teal.withOpacity(0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
