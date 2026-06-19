import '../../domain/entities/DashboardSummaryEntity.dart';

abstract class DashboardRemoteDataSource {
  Future<DashboardSummaryEntity> getDashboardSummary();
}
