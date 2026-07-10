import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/sp_bottom_nav.dart';
import '../../../core/providers/NavigationProvider.dart';
import '../../../dashboard/presentation/pages/DashboardContent.dart';
import '../../../gateway/presentation/pages/GatewayListPage.dart';
import '../../../plantation/presentation/pages/PlantationListPage.dart';
import '../../../profile/presentation/pages/ProfilePage.dart';
import '../../../../report/presentation/pages/ReportsPage.dart';

// `alert` y `report` viven fuera de `feature/` (inconsistencia preexistente
// del proyecto, no introducida aquí).
import '../../../../alert/presentation/pages/AlertsPage.dart';

class SmartPalmHomePage extends StatelessWidget {
  const SmartPalmHomePage({super.key});

  static const _pages = [
    DashboardContent(),
    PlantationListPage(),
    AlertsPage(),
    GatewayListPage(),
    ReportsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Palm')),
      body: IndexedStack(index: nav.selectedIndex, children: _pages),
      bottomNavigationBar: SPBottomNav(
        currentIndex: nav.selectedIndex,
        onTap: nav.switchTab,
      ),
    );
  }
}
