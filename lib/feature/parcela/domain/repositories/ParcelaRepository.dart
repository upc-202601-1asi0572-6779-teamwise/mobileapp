import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/ParcelaEntity.dart';
import '../entities/ParcelaDetailEntity.dart';

abstract class ParcelaRepository {
  Future<Either<Failure, List<ParcelaEntity>>> getParcelas();
  Future<Either<Failure, ParcelaDetailEntity>> getParcelaById(int id);
}
