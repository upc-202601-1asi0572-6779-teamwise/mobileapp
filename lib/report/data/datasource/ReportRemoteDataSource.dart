import '../../domain/entities/ReportEntity.dart';

abstract class ReportRemoteDataSource {
  Future<List<ReportEntity>> getReports();
  Future<ReportEntity> generateReport(ReportType type, {int? blockId});
}
