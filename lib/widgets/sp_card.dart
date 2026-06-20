import 'package:flutter/material.dart';
import '../smartpalm_tokens.dart';

class SPCard extends StatelessWidget {
  const SPCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final content = padding != null ? Padding(padding: padding!, child: child) : child;

    return Container(
      margin: margin ?? const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: SPColors.card,
        borderRadius: SPRadius.cardRadius,
        border: Border.all(color: SPColors.border),
        boxShadow: SPShadows.card,
      ),
      child: ClipRRect(
        borderRadius: SPRadius.cardRadius,
        child: onTap != null
            ? InkWell(
                onTap: onTap,
                borderRadius: SPRadius.cardRadius,
                child: content,
              )
            : content,
      ),
    );
  }
}

class SPSectionHeader extends StatelessWidget {
  const SPSectionHeader({
    super.key,
    required this.title,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        children: [
          Text(title, style: SPType.sectionHeading.copyWith(color: SPColors.text)),
          const Spacer(),
          if (actionLabel != null)
            GestureDetector(
              onTap: onAction,
              child: Text(
                actionLabel!,
                style: SPType.body.copyWith(
                  color: SPColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
