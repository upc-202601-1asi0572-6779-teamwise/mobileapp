import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/DashboardSummaryEntity.dart';
import 'DashboardRemoteDataSource.dart';

class DashboardHttpDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<DashboardSummaryEntity> getDashboardSummary() async {
    final data = await ApiClient.get('/dashboard');
    return DashboardSummaryEntity.fromJson(data as Map<String, dynamic>);
  }
}
