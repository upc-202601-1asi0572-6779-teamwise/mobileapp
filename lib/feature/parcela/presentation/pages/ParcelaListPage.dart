import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_header.dart';
import '../../../../widgets/sp_card.dart';
import '../../../../widgets/sp_chip.dart';
import '../providers/ParcelaProvider.dart';
import '../../domain/entities/ParcelaEntity.dart';

class ParcelaListPage extends StatefulWidget {
  const ParcelaListPage({super.key});

  @override
  State<ParcelaListPage> createState() => _ParcelaListPageState();
}

class _ParcelaListPageState extends State<ParcelaListPage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ParcelaProvider>().loadParcelas();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParcelaProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: Column(
        children: [
          SPHeader(
            title: 'Mis Parcelas',
            subtitle:
            '${provider.parcelas.length} parcelas · ${provider.parcelas.fold(0, (s, p) => s + p.nodes)} sensores activos',
            action: SPHeaderActionButton(
              icon: Icons.add,
              onTap: () {},
            ),
          ),
          Expanded(
            child: switch (provider.status) {
              ParcelaStatus.loading => const Center(
                  child: CircularProgressIndicator(color: SPColors.primary)),
              ParcelaStatus.error => Center(
                  child: Text(provider.errorMessage, style: SPType.body)),
              ParcelaStatus.loaded =>
                  _ParcelaList(parcelas: provider.parcelas),
              _ => const SizedBox.shrink(),
            },
          ),
        ],
      ),
    );
  }
}

class _ParcelaList extends StatelessWidget {
  final List<ParcelaEntity> parcelas;
  const _ParcelaList({required this.parcelas});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(SPSpacing.lg),
      children: [
        SPCard(
          padding: const EdgeInsets.symmetric(
              horizontal: SPSpacing.m, vertical: SPSpacing.md),
          child: Row(children: [
            const Icon(Icons.search, size: 16, color: SPColors.muted),
            const SizedBox(width: 10),
            Text('Buscar parcela…',
                style: SPType.body.copyWith(color: SPColors.muted)),
          ]),
        ),
        const SizedBox(height: 4),
        ...parcelas.map((p) => _ParcelaCard(parcela: p)),
        const SizedBox(height: 60),
      ],
    );
  }
}

class _ParcelaCard extends StatelessWidget {
  final ParcelaEntity parcela;
  const _ParcelaCard({required this.parcela});

  @override
  Widget build(BuildContext context) {
    final spStatus = SPStatusTokens.fromString(parcela.status);
    final barColor = plotHealthColor(spStatus);

    return SPCard(
      onTap: () => Navigator.pushNamed(
        context, '/parcela_detail',
        arguments: parcela.id,
      ),
      padding: const EdgeInsets.all(SPSpacing.lg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(parcela.name,
                style: SPType.cardTitle.copyWith(
                    fontSize: 16, color: SPColors.text)),
            SPStatusChip(status: spStatus),
          ],
        ),
        const SizedBox(height: 6),
        Row(children: [
          Text('${parcela.hectares.toInt()} ha',
              style: SPType.caption.copyWith(color: SPColors.body)),
          const SizedBox(width: 14),
          Text('${parcela.nodes} sensores',
              style: SPType.caption.copyWith(color: SPColors.body)),
          const SizedBox(width: 14),
          Text('Últ. lectura: ${parcela.lastReading}',
              style: SPType.caption.copyWith(color: SPColors.muted)),
        ]),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(2),
          child: LinearProgressIndicator(
            value: parcela.healthPct,
            minHeight: 4,
            backgroundColor: barColor.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation(barColor),
          ),
        ),
      ]),
    );
  }
}
