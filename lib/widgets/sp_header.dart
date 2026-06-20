import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import '../smartpalm_tokens.dart';

class SPHeader extends StatelessWidget {
  const SPHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.action,
    this.onBack,
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final Widget? action;
  final VoidCallback? onBack;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: EdgeInsets.fromLTRB(
        SPSpacing.xl,
        SPSpacing.x6l,
        SPSpacing.xl,
        SPSpacing.x2l,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showBack)
            GestureDetector(
              onTap: onBack ?? () => Navigator.of(context).pop(),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.arrow_back, size: 18, color: Color(0xB3FFFFFF)),
                    const SizedBox(width: 6),
                    Text(
                      'Atrás',
                      style: SPType.bodySmall.copyWith(color: const Color(0xB3FFFFFF)),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: SPType.hero.copyWith(color: Colors.white),
                ),
              ),
              if (action != null) ...[
                const SizedBox(width: 12),
                action!,
              ],
            ],
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: SPType.bodySmall.copyWith(color: const Color(0xA6FFFFFF)),
            ),
          ],
        ],
      ),
    );
  }
}


class SPHeaderActionButton extends StatelessWidget {
  const SPHeaderActionButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0x26FFFFFF),
          borderRadius: BorderRadius.circular(SPRadius.action),
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
