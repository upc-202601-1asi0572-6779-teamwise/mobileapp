import 'package:flutter/material.dart';
import '../smartpalm_tokens.dart';
import 'sp_chip.dart';

class SPAlertRow extends StatelessWidget {
  const SPAlertRow({
    super.key,
    required this.level,
    required this.title,
    required this.subtitle,
    required this.time,
    this.showDivider = true,
  });

  final AlertLevel level;
  final String title;
  final String subtitle;
  final String time;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final color = SPAlertTokens.color[level]!;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: SPStatusDot(color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: SPType.body.copyWith(
                      fontWeight: FontWeight.w500, color: SPColors.text,
                    )),
                    const SizedBox(height: 2),
                    Text(
                      subtitle.isNotEmpty ? '$subtitle · $time' : time,
                      style: SPType.caption.copyWith(color: SPColors.muted),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SPAlertBadge(level: level),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
      ],
    );
  }
}

class SPAlertList extends StatelessWidget {
  const SPAlertList({super.key, required this.alerts});

  final List<({AlertLevel level, String title, String subtitle, String time})> alerts;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(alerts.length, (i) {
        final a = alerts[i];
        return SPAlertRow(
          level: a.level,
          title: a.title,
          subtitle: a.subtitle,
          time: a.time,
          showDivider: i < alerts.length - 1,
        );
      }),
    );
  }
}
