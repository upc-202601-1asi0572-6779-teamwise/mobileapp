import 'package:flutter/material.dart';
import '../smartpalm_tokens.dart';

class SPStatusChip extends StatelessWidget {
  const SPStatusChip({
    super.key,
    required this.status,
  });

  factory SPStatusChip.fromString(String s) =>
      SPStatusChip(status: SPStatusTokens.fromString(s));

  final SPStatus status;

  @override
  Widget build(BuildContext context) {
    final (:bg, :text, :label) = SPStatusTokens.map[status]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: SPRadius.badgeRadius),
      child: Text(label, style: SPType.tag.copyWith(color: text)),
    );
  }
}

class SPAlertBadge extends StatelessWidget {
  const SPAlertBadge({super.key, required this.level});

  factory SPAlertBadge.fromString(String s) =>
      SPAlertBadge(level: SPAlertTokens.fromString(s));

  final AlertLevel level;

  @override
  Widget build(BuildContext context) {
    final color = SPAlertTokens.color[level]!;
    final label = SPAlertTokens.label[level]!;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label, style: SPType.tag.copyWith(color: color, fontSize: 10)),
    );
  }
}

class SPBadge extends StatelessWidget {
  const SPBadge({
    super.key,
    required this.label,
    required this.bg,
    required this.textColor,
    this.borderColor,
  });

  final String label;
  final Color bg;
  final Color textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: SPRadius.badgeRadius,
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Text(label, style: SPType.tag.copyWith(color: textColor)),
    );
  }
}

class SPStatusDot extends StatelessWidget {
  const SPStatusDot({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
