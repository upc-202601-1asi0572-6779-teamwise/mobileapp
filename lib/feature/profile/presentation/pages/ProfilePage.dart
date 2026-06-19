import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../smartpalm_tokens.dart';
import '../../../../widgets/sp_card.dart';
import '../providers/ProfileProvider.dart';
import '../../domain/entities/ProfileEntity.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileProvider>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProfileProvider>();
    return ColoredBox(
      color: SPColors.bg,
      child: switch (provider.status) {
        ProfileStatus.loading => const Center(
            child: CircularProgressIndicator(color: SPColors.primary)),
        ProfileStatus.error =>
          Center(child: Text(provider.errorMessage, style: SPType.body)),
        ProfileStatus.loaded =>
          _ProfileBody(profile: provider.profile!),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _ProfileBody extends StatelessWidget {
  final ProfileEntity profile;
  const _ProfileBody({required this.profile});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        _ProfileHeader(profile: profile),
        Padding(
          padding: const EdgeInsets.all(SPSpacing.lg),
          child: Column(children: [
            _StatsRow(profile: profile),
            const SizedBox(height: SPSpacing.lg),
            const _PreferencesSection(),
            const SizedBox(height: SPSpacing.lg),
            const _TeamSection(),
            const SizedBox(height: SPSpacing.lg),
            const _LogoutButton(),
            const SizedBox(height: 60),
          ]),
        ),
      ]),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final ProfileEntity profile;
  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
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
              profile.initials,
              style: SPType.hero.copyWith(
                  fontSize: 22, color: SPColors.primaryDark),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(profile.name,
                style: SPType.hero.copyWith(fontSize: 22, color: Colors.white)),
            const SizedBox(height: 2),
            Text('${profile.farm} · ${profile.location}',
                style: SPType.caption.copyWith(color: const Color(0xA6FFFFFF))),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0x334CCD82),
                border: Border.all(color: const Color(0x594CCD82)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                profile.plan,
                style: SPType.tag.copyWith(
                    color: const Color(0xFF86EFAC), fontWeight: FontWeight.w600),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}

class _StatsRow extends StatelessWidget {
  final ProfileEntity profile;
  const _StatsRow({required this.profile});

  @override
  Widget build(BuildContext context) {
    final stats = <(String, String)>[
      ('${profile.totalHectares.toInt()} ha', 'Superficie'),
      ('${profile.totalSensors}', 'Sensores'),
      ('${profile.totalParcelas}', 'Parcelas'),
    ];
    return Row(
      children: stats.map<Widget>((s) {
        final value = s.$1;
        final label = s.$2;
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: label != 'Parcelas' ? 10 : 0),
            child: SPCard(
              margin: EdgeInsets.zero,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
              child: Column(children: [
                Text(value,
                    style: SPType.metricValue.copyWith(
                        fontSize: 20, color: SPColors.primaryDark)),
                const SizedBox(height: 2),
                Text(label,
                    style: SPType.caption.copyWith(color: SPColors.muted)),
              ]),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _PreferencesSection extends StatelessWidget {
  const _PreferencesSection();

  @override
  Widget build(BuildContext context) {
    const prefs = <(IconData, String, String)>[
      (Icons.language, 'Idioma', 'Español'),
      (Icons.notifications_outlined, 'Notificaciones', 'Activadas'),
      (Icons.wifi, 'Red LoRaWAN', 'SP-GW-001'),
    ];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Preferencias',
          style: SPType.sectionHeading.copyWith(color: SPColors.text)),
      const SizedBox(height: 10),
      SPCard(
        child: Column(
          children: List.generate(prefs.length, (i) {
            final icon = prefs[i].$1;
            final label = prefs[i].$2;
            final value = prefs[i].$3;
            return Column(children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: SPSpacing.lg, vertical: 13),
                child: Row(children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(
                      color: SPColors.softGreen,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon, color: SPColors.primaryDark, size: 16),
                  ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(label, style: SPType.body)),
                  Text(value,
                      style: SPType.bodySmall.copyWith(color: SPColors.muted)),
                  const Icon(Icons.chevron_right,
                      color: SPColors.muted, size: 16),
                ]),
              ),
              if (i < prefs.length - 1)
                const Divider(height: 1, color: Color(0xFFF3F4F6)),
            ]);
          }),
        ),
      ),
    ]);
  }
}

class _TeamSection extends StatelessWidget {
  const _TeamSection();

  static const _team = [
    ('VR', 'Víctor Rojas',  'Lead Engineer', Color(0xFFA8F0C6)),
    ('RJ', 'Renso Julca',   'Backend IoT',   Color(0xFFCFF9FE)),
    ('JP', 'Jeremy Paucar', 'Mobile Dev',    Color(0xFFFEF3C7)),
    ('RL', 'Renzo Loli',    'Frontend Web',  Color(0xFFEEF5F1)),
    ('JT', 'Javier Tello',  'Embedded Sys',  Color(0xFFD1FAE5)),
    ('SC', 'Sebastian C.',  'UX / QA',       Color(0xFFFDE8D8)),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Equipo TempWise · UPC',
          style: SPType.sectionHeading.copyWith(color: SPColors.text)),
      const SizedBox(height: 10),
      SPCard(
        padding: const EdgeInsets.all(SPSpacing.m),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 3.5,
          children: _team.map<Widget>((m) =>
            _TeamMember(initials: m.$1, name: m.$2,
                role: m.$3, avatarColor: m.$4),
          ).toList(),
        ),
      ),
    ]);
  }
}

class _TeamMember extends StatelessWidget {
  final String initials, name, role;
  final Color avatarColor;
  const _TeamMember(
      {required this.initials, required this.name,
       required this.role, required this.avatarColor});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      CircleAvatar(
        radius: 19,
        backgroundColor: avatarColor,
        child: Text(initials,
            style: SPType.tag.copyWith(
                color: SPColors.primaryDark, fontSize: 13)),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(name,
              style: SPType.caption.copyWith(
                  fontWeight: FontWeight.w600, color: SPColors.text),
              overflow: TextOverflow.ellipsis),
          Text(role,
              style: SPType.caption.copyWith(color: SPColors.muted),
              overflow: TextOverflow.ellipsis),
        ]),
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
        padding: const EdgeInsets.symmetric(
            horizontal: SPSpacing.m, vertical: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFEF2F2),
          border: Border.all(color: const Color(0xFFFECACA)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Icon(Icons.logout, color: SPColors.crit, size: 18),
          const SizedBox(width: 10),
          Text('Cerrar sesión',
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
        content:
            const Text('¿Estás seguro de que deseas cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ProfileProvider>().logout(context);
            },
            style: FilledButton.styleFrom(backgroundColor: SPColors.crit),
            child: const Text('Cerrar sesión'),
          ),
        ],
      ),
    );
  }
}
