import 'package:dartz/dartz.dart';
import '../../../feature/core/error/Failure.dart';
import '../entities/ReportEntity.dart';

abstract class ReportRepository {
  Future<Either<Failure, List<ReportEntity>>> getReports();
  Future<Either<Failure, ReportEntity>> generateReport(ReportType type, {int? blockId});
}
