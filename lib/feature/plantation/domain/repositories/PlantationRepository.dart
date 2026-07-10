import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/PlantationEntity.dart';
import '../entities/SectorEntity.dart';

abstract class PlantationRepository {
  Future<Either<Failure, List<PlantationEntity>>> getMyPlantations();
  Future<Either<Failure, PlantationDetailEntity>> getPlantationDetail(int plantationId);
}
