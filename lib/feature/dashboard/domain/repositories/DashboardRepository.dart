import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/DashboardSummaryEntity.dart';

abstract class DashboardRepository {
  Future<Either<Failure, DashboardSummaryEntity>> getDashboardSummary();
}
