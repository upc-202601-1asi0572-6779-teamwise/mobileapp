import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'smartpalm_theme.dart';
import 'core/di/ServiceLocator.dart';
import 'feature/core/providers/NavigationProvider.dart';
import 'feature/dashboard/presentation/providers/DashboardProvider.dart';
import 'feature/parcela/presentation/providers/ParcelaProvider.dart';
import 'feature/parcela/presentation/providers/ParcelaDetailProvider.dart';
import 'feature/alert/presentation/providers/AlertProvider.dart';
import 'feature/sensor/presentation/providers/SensorProvider.dart';
import 'feature/report/presentation/providers/ReportProvider.dart';
import 'feature/profile/presentation/providers/ProfileProvider.dart';
import 'feature/login/presentation/pages/LoginPage.dart';
import 'feature/smartpalm_home/presentation/pages/SmartPalmHomePage.dart';
import 'feature/parcela/presentation/pages/ParcelaDetailPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await setupServiceLocator();
  runApp(const SmartPalmApp());
}

class SmartPalmApp extends StatelessWidget {
  const SmartPalmApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sl<NavigationProvider>()),
        ChangeNotifierProvider(create: (_) => sl<DashboardProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ParcelaProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ParcelaDetailProvider>()),
        ChangeNotifierProvider(create: (_) => sl<AlertProvider>()),
        ChangeNotifierProvider(create: (_) => sl<SensorProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ReportProvider>()),
        ChangeNotifierProvider(create: (_) => sl<ProfileProvider>()),
      ],
      child: MaterialApp(
        title: 'SmartPalm',
        debugShowCheckedModeBanner: false,
        theme: SPTheme.light,
        initialRoute: '/home', // TODO: re-enable '/login' when IAM móvil esté habilitado
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const SmartPalmHomePage(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == '/parcela_detail') {
            final id = settings.arguments as int;
            return MaterialPageRoute(
              builder: (_) => ParcelaDetailPage(parcelaId: id),
            );
          }
          return null;
        },
      ),
    );
  }
}
