import 'package:get_it/get_it.dart';

import '../../feature/dashboard/data/datasource/DashboardRemoteDataSource.dart';
import '../../feature/dashboard/data/datasource/DashboardHttpDataSourceImpl.dart';
import '../../feature/dashboard/data/repositories/DashboardRepositoryImpl.dart';
import '../../feature/dashboard/domain/repositories/DashboardRepository.dart';
import '../../feature/dashboard/domain/usecases/GetDashboardSummaryUseCase.dart';
import '../../feature/dashboard/presentation/providers/DashboardProvider.dart';

import '../../feature/parcela/data/datasource/ParcelaRemoteDataSource.dart';
import '../../feature/parcela/data/datasource/ParcelaHttpDataSourceImpl.dart';
import '../../feature/parcela/data/repositories/ParcelaRepositoryImpl.dart';
import '../../feature/parcela/domain/repositories/ParcelaRepository.dart';
import '../../feature/parcela/domain/usecases/GetParcelasUseCase.dart';
import '../../feature/parcela/domain/usecases/GetParcelaByIdUseCase.dart';
import '../../feature/parcela/presentation/providers/ParcelaProvider.dart';
import '../../feature/parcela/presentation/providers/ParcelaDetailProvider.dart';

import '../../feature/alert/data/datasource/AlertRemoteDataSource.dart';
import '../../feature/alert/data/datasource/AlertHttpDataSourceImpl.dart';
import '../../feature/alert/data/repositories/AlertRepositoryImpl.dart';
import '../../feature/alert/domain/repositories/AlertRepository.dart';
import '../../feature/alert/domain/usecases/GetAlertsUseCase.dart';
import '../../feature/alert/presentation/providers/AlertProvider.dart';

import '../../feature/sensor/data/datasource/SensorRemoteDataSource.dart';
import '../../feature/sensor/data/datasource/SensorHttpDataSourceImpl.dart';
import '../../feature/sensor/data/repositories/SensorRepositoryImpl.dart';
import '../../feature/sensor/domain/repositories/SensorRepository.dart';
import '../../feature/sensor/domain/usecases/GetSensorsUseCase.dart';
import '../../feature/sensor/presentation/providers/SensorProvider.dart';

import '../../feature/report/data/datasource/ReportRemoteDataSource.dart';
import '../../feature/report/data/datasource/ReportHttpDataSourceImpl.dart';
import '../../feature/report/data/repositories/ReportRepositoryImpl.dart';
import '../../feature/report/domain/repositories/ReportRepository.dart';
import '../../feature/report/domain/usecases/GetReportsUseCase.dart';
import '../../feature/report/domain/usecases/GenerateReportUseCase.dart';
import '../../feature/report/presentation/providers/ReportProvider.dart';

import '../../feature/profile/data/datasource/ProfileRemoteDataSource.dart';
import '../../feature/profile/data/datasource/ProfileHttpDataSourceImpl.dart';
import '../../feature/profile/data/repositories/ProfileRepositoryImpl.dart';
import '../../feature/profile/domain/repositories/ProfileRepository.dart';
import '../../feature/profile/domain/usecases/GetProfileUseCase.dart';
import '../../feature/profile/presentation/providers/ProfileProvider.dart';

import '../../feature/core/providers/NavigationProvider.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Navigation
  sl.registerLazySingleton(() => NavigationProvider());

  // Dashboard
  sl.registerLazySingleton<DashboardRemoteDataSource>(
          () => DashboardHttpDataSourceImpl());
  sl.registerLazySingleton<DashboardRepository>(() =>
      DashboardRepositoryImpl(remoteDataSource: sl<DashboardRemoteDataSource>()));
  sl.registerLazySingleton(() => GetDashboardSummaryUseCase(sl()));
  sl.registerFactory(() =>
      DashboardProvider(getDashboardSummaryUseCase: sl()));

  // Parcela
  sl.registerLazySingleton<ParcelaRemoteDataSource>(
          () => ParcelaHttpDataSourceImpl());
  sl.registerLazySingleton<ParcelaRepository>(() =>
      ParcelaRepositoryImpl(remoteDataSource: sl<ParcelaRemoteDataSource>()));
  sl.registerLazySingleton(() => GetParcelasUseCase(sl()));
  sl.registerLazySingleton(() => GetParcelaByIdUseCase(sl()));
  sl.registerFactory(() => ParcelaProvider(getParcelasUseCase: sl()));
  sl.registerFactory(() => ParcelaDetailProvider(getParcelaByIdUseCase: sl()));

  // Alert
  sl.registerLazySingleton<AlertRemoteDataSource>(
          () => AlertHttpDataSourceImpl());
  sl.registerLazySingleton<AlertRepository>(() =>
      AlertRepositoryImpl(remoteDataSource: sl<AlertRemoteDataSource>()));
  sl.registerLazySingleton(() => GetAlertsUseCase(sl()));
  sl.registerFactory(() => AlertProvider(getAlertsUseCase: sl()));

  // Sensor
  sl.registerLazySingleton<SensorRemoteDataSource>(
          () => SensorHttpDataSourceImpl());
  sl.registerLazySingleton<SensorRepository>(() =>
      SensorRepositoryImpl(remoteDataSource: sl<SensorRemoteDataSource>()));
  sl.registerLazySingleton(() => GetSensorsUseCase(sl()));
  sl.registerFactory(() => SensorProvider(getSensorsUseCase: sl()));

  // Report
  sl.registerLazySingleton<ReportRemoteDataSource>(
          () => ReportHttpDataSourceImpl());
  sl.registerLazySingleton<ReportRepository>(() =>
      ReportRepositoryImpl(remoteDataSource: sl<ReportRemoteDataSource>()));
  sl.registerLazySingleton(() => GetReportsUseCase(sl()));
  sl.registerLazySingleton(() => GenerateReportUseCase(sl()));
  sl.registerFactory(() => ReportProvider(
      getReportsUseCase: sl(), generateReportUseCase: sl()));

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
          () => ProfileHttpDataSourceImpl());
  sl.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepositoryImpl(remoteDataSource: sl<ProfileRemoteDataSource>()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerFactory(() => ProfileProvider(getProfileUseCase: sl()));
}
