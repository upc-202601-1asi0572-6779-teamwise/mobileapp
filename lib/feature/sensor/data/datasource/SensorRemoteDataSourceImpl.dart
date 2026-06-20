import '../../domain/entities/SensorEntity.dart';
import 'SensorRemoteDataSource.dart';

class SensorRemoteDataSourceImpl implements SensorRemoteDataSource {
  @override
  Future<List<SensorEntity>> getSensors() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const [
      SensorEntity(id: 'SP-001', block: 'Bloque A', lastPing: 'hace 2 min',  batteryLevel: 85, status: 'activo'),
      SensorEntity(id: 'SP-002', block: 'Bloque A', lastPing: 'hace 5 min',  batteryLevel: 72, status: 'activo'),
      SensorEntity(id: 'SP-003', block: 'Bloque B', lastPing: 'hace 18 min', batteryLevel: 45, status: 'alerta'),
      SensorEntity(id: 'SP-004', block: 'Bloque C', lastPing: 'hace 2 h',    batteryLevel: 12, status: 'sinsenal'),
      SensorEntity(id: 'SP-005', block: 'Bloque D', lastPing: 'hace 3 min',  batteryLevel: 91, status: 'activo'),
    ];
  }
}
