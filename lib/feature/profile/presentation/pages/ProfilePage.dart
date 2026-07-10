import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../../../auth/presentation/providers/AuthProvider.dart';
import '../../../core/providers/NavigationProvider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    final auth = context.watch<AuthProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: SingleChildScrollView(
        child: Column(children: [
          _ProfileHeader(auth: auth),
          Padding(
            padding: const EdgeInsets.all(SPSpacing.lg),
            child: Column(children: [
              const _NoDataSection(title: 'Mi actividad'),
              const SizedBox(height: SPSpacing.lg),
              const _LogoutButton(),
              const SizedBox(height: 60),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AuthProvider auth;
  const _ProfileHeader({required this.auth});

  String _initials(String? name, String? username) {
    final source = (name != null && name.trim().isNotEmpty) ? name : (username ?? '?');
    final parts = source.trim().split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1)).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final displayName = (auth.fullName != null && auth.fullName!.trim().isNotEmpty)
        ? auth.fullName!
        : (auth.username ?? '');
    return Container(
      decoration: const BoxDecoration(gradient: SPColors.headerGradient),
      padding: const EdgeInsets.fromLTRB(
          SPSpacing.xl, SPSpacing.x6l, SPSpacing.xl, SPSpacing.x3l),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x4DFFFFFF), width: 3),
          ),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: const Color(0xFF4CCD82),
            child: Text(
              _initials(auth.fullName, auth.username),
              style: SPType.hero.copyWith(fontSize: 22, color: SPColors.primaryDark),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(displayName,
                style: SPType.hero.copyWith(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 2),
            Text(auth.email ?? '',
                style: SPType.caption.copyWith(color: const Color(0xA6FFFFFF))),
            if (auth.role != null) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x334CCD82),
                  border: Border.all(color: const Color(0x594CCD82)),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  auth.role!,
                  style: SPType.tag.copyWith(
                      color: const Color(0xFF86EFAC), fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ]),
        ),
      ]),
    );
  }
}

class _NoDataSection extends StatelessWidget {
  final String title;
  const _NoDataSection({required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: SPType.sectionHeading.copyWith(color: SPColors.text)),
      const SizedBox(height: 10),
      SPCard(
        padding: const EdgeInsets.symmetric(vertical: SPSpacing.x2l, horizontal: SPSpacing.lg),
        child: Center(
          child: Text('No hay datos registrados aún',
              style: SPType.body.copyWith(color: SPColors.muted)),
        ),
      ),
    ]);
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _confirmLogout(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SPSpacing.m, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          border: Border.all(color: const Color(0xFFFECACA)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.logout, color: SPColors.crit, size: 18),
          const SizedBox(width: 10),
          Text('Cerrar Sesión',
              style: SPType.sectionHeading.copyWith(
                  color: SPColors.crit, fontWeight: FontWeight.w600)),
        ]),
      ),
    );
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cerrar sesión'),
        content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              await context.read<AuthProvider>().signOut();
              context.read<NavigationProvider>().switchTab(0);
              if (context.mounted) {
                Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
              }
            },
            style: FilledButton.styleFrom(backgroundColor: SPColors.crit),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
