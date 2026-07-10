import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_header.dart';
import '../../../../widgets/sp_card.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: SPColors.bg,
      child: Column(children: [
        const SPHeader(
          title: 'Reportes',
          subtitle: 'Exporta y comparte datos',
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(SPSpacing.x3l),
              child: SPCard(
                padding: const EdgeInsets.symmetric(
                    vertical: SPSpacing.x2l, horizontal: SPSpacing.lg),
                child: Text('No hay datos registrados aún',
                    style: SPType.body.copyWith(color: SPColors.muted)),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
