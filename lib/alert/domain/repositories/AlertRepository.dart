import 'package:dartz/dartz.dart';
import '../../../feature/core/error/Failure.dart';
import '../entities/AlertEntity.dart';

abstract class AlertRepository {
  Future<Either<Failure, List<AlertEntity>>> getAlerts();
}
