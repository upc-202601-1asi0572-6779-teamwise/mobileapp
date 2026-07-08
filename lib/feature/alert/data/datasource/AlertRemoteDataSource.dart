import '../../domain/entities/AlertEntity.dart';

abstract class AlertRemoteDataSource {
  Future<List<AlertEntity>> getAlerts();
}
