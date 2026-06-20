import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/SensorEntity.dart';
import 'SensorRemoteDataSource.dart';

class SensorHttpDataSourceImpl implements SensorRemoteDataSource {
  @override
  Future<List<SensorEntity>> getSensors() async {
    final data = await ApiClient.get('/sensors') as List;
    return data.map((e) => SensorEntity.fromJson(e as Map<String, dynamic>)).toList();
  }
}
