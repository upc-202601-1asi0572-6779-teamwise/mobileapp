import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/SensorEntity.dart';
import '../../domain/repositories/SensorRepository.dart';
import '../datasource/SensorRemoteDataSource.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorRemoteDataSource _dataSource;

  SensorRepositoryImpl({required SensorRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<SensorEntity>>> getSensors() async {
    try {
      return Right(await _dataSource.getSensors());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
