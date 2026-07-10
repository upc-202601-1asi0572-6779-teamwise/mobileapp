import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/AlertEntity.dart';
import 'AlertRemoteDataSource.dart';

class AlertHttpDataSourceImpl implements AlertRemoteDataSource {
  @override
  Future<List<AlertEntity>> getAlerts() async {
    final data = await ApiClient.get('/api/v1/alerts') as List;
    return data.map((e) => AlertEntity.fromJson(e as Map<String, dynamic>)).toList();
  }
}
