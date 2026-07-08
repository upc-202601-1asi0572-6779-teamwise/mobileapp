import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/sp_bottom_nav.dart';
import '../../../core/providers/NavigationProvider.dart';
import '../../../dashboard/presentation/pages/DashboardContent.dart';
import '../../../parcela/presentation/pages/ParcelaListPage.dart';
import '../../../alert/presentation/pages/AlertsPage.dart';
import '../../../sensor/presentation/pages/SensorsPage.dart';
import '../../../report/presentation/pages/ReportsPage.dart';
import '../../../profile/presentation/pages/ProfilePage.dart';

class SmartPalmHomePage extends StatelessWidget {
  const SmartPalmHomePage({super.key});

  static const _pages = <Widget>[
    DashboardContent(),
    ParcelaListPage(),
    AlertsPage(),
    SensorsPage(),
    ReportsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return Scaffold(
      body: IndexedStack(
        index: nav.selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SPBottomNav(
        currentIndex: nav.selectedIndex,
        onTap: nav.switchTab,
      ),
    );
  }
}
