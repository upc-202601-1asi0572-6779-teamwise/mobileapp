import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/SensorEntity.dart';

abstract class SensorRepository {
  Future<Either<Failure, List<SensorEntity>>> getSensors();
}
