import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/EdgeGatewayEntity.dart';
import '../../domain/entities/IotDeviceEntity.dart';
import '../../domain/entities/SensorReadingEntity.dart';
import 'GatewayRemoteDataSource.dart';

class GatewayHttpDataSourceImpl implements GatewayRemoteDataSource {
  @override
  Future<List<EdgeGatewayEntity>> getMyGateways() async {
    final data = await ApiClient.get('/api/v1/edge-gateways') as List;
    return data
        .map((e) => EdgeGatewayEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<IotDeviceEntity>> getGatewayDevices(String gatewayMac) async {
    final data =
        await ApiClient.get('/api/v1/edge-gateways/$gatewayMac/devices') as Map<String, dynamic>;
    final devices = data['devices'] as List;
    return devices
        .map((e) => IotDeviceEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<SensorReadingEntity>> getDeviceReadings(String deviceMac) async {
    final data = await ApiClient.get('/api/v1/devices/$deviceMac/sensor-readings') as List;
    return data
        .map((e) => SensorReadingEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
