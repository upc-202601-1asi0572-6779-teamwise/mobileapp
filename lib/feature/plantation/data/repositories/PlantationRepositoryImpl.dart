import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/PlantationEntity.dart';
import '../../domain/entities/SectorEntity.dart';
import '../../domain/repositories/PlantationRepository.dart';
import '../datasource/PlantationRemoteDataSource.dart';

class PlantationRepositoryImpl implements PlantationRepository {
  final PlantationRemoteDataSource _dataSource;

  PlantationRepositoryImpl({required PlantationRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<PlantationEntity>>> getMyPlantations() async {
    try {
      return Right(await _dataSource.getMyPlantations());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PlantationDetailEntity>> getPlantationDetail(int plantationId) async {
    try {
      return Right(await _dataSource.getPlantationDetail(plantationId));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
