import '../../domain/entities/SensorEntity.dart';

abstract class SensorRemoteDataSource {
  Future<List<SensorEntity>> getSensors();
}
