import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'smartpalm_theme.dart';

import 'core/session/SessionStorage.dart';
import 'feature/core/providers/NavigationProvider.dart';

import 'feature/auth/data/datasource/AuthHttpDataSourceImpl.dart';
import 'feature/auth/data/repositories/AuthRepositoryImpl.dart';
import 'feature/auth/domain/usecases/SignInUseCase.dart';
import 'feature/auth/presentation/providers/AuthProvider.dart';
import 'feature/login/presentation/pages/LoginPage.dart';

import 'feature/gateway/data/datasource/GatewayHttpDataSourceImpl.dart';
import 'feature/gateway/data/repositories/GatewayRepositoryImpl.dart';
import 'feature/gateway/domain/usecases/GetDeviceReadingsUseCase.dart';
import 'feature/gateway/domain/usecases/GetGatewayDevicesUseCase.dart';
import 'feature/gateway/domain/usecases/GetMyGatewaysUseCase.dart';
import 'feature/gateway/presentation/providers/GatewayProvider.dart';

import 'feature/plantation/data/datasource/PlantationHttpDataSourceImpl.dart';
import 'feature/plantation/data/repositories/PlantationRepositoryImpl.dart';
import 'feature/plantation/domain/usecases/GetMyPlantationsUseCase.dart';
import 'feature/plantation/domain/usecases/GetPlantationDetailUseCase.dart';
import 'feature/plantation/presentation/providers/PlantationProvider.dart';

import 'alert/data/datasource/AlertHttpDataSourceImpl.dart';
import 'alert/data/repositories/AlertRepositoryImpl.dart';
import 'alert/domain/usecases/GetAlertsUseCase.dart';
import 'alert/presentation/providers/AlertProvider.dart';

import 'feature/smartpalm_home/presentation/pages/SmartPalmHomePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(
          create: (_) => AuthProvider(
            signInUseCase: SignInUseCase(
              AuthRepositoryImpl(remoteDataSource: AuthHttpDataSourceImpl()),
            ),
            sessionStorage: SessionStorage(),
          )..restoreSession(),
        ),
        ChangeNotifierProvider(
          create: (_) => GatewayProvider(
            getMyGatewaysUseCase: GetMyGatewaysUseCase(
              GatewayRepositoryImpl(remoteDataSource: GatewayHttpDataSourceImpl()),
            ),
            getGatewayDevicesUseCase: GetGatewayDevicesUseCase(
              GatewayRepositoryImpl(remoteDataSource: GatewayHttpDataSourceImpl()),
            ),
            getDeviceReadingsUseCase: GetDeviceReadingsUseCase(
              GatewayRepositoryImpl(remoteDataSource: GatewayHttpDataSourceImpl()),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => PlantationProvider(
            getMyPlantationsUseCase: GetMyPlantationsUseCase(
              PlantationRepositoryImpl(remoteDataSource: PlantationHttpDataSourceImpl()),
            ),
            getPlantationDetailUseCase: GetPlantationDetailUseCase(
              PlantationRepositoryImpl(remoteDataSource: PlantationHttpDataSourceImpl()),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => AlertProvider(
            getAlertsUseCase: GetAlertsUseCase(
              AlertRepositoryImpl(remoteDataSource: AlertHttpDataSourceImpl()),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Smart Palm',
        debugShowCheckedModeBanner: false,
        theme: SPTheme.light,
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginPage(),
          '/home': (_) => const SmartPalmHomePage(),
        },
      ),
    );
  }
}
