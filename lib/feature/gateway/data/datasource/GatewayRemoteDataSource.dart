import '../../domain/entities/EdgeGatewayEntity.dart';
import '../../domain/entities/IotDeviceEntity.dart';
import '../../domain/entities/SensorReadingEntity.dart';

abstract class GatewayRemoteDataSource {
  Future<List<EdgeGatewayEntity>> getMyGateways();
  Future<List<IotDeviceEntity>> getGatewayDevices(String gatewayMac);
  Future<List<SensorReadingEntity>> getDeviceReadings(String deviceMac);
}
