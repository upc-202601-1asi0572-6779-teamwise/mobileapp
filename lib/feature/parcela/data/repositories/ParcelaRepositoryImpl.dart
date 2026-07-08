import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/ParcelaEntity.dart';
import '../../domain/entities/ParcelaDetailEntity.dart';
import '../../domain/repositories/ParcelaRepository.dart';
import '../datasource/ParcelaRemoteDataSource.dart';

class ParcelaRepositoryImpl implements ParcelaRepository {
  final ParcelaRemoteDataSource _dataSource;

  ParcelaRepositoryImpl({required ParcelaRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<ParcelaEntity>>> getParcelas() async {
    try {
      return Right(await _dataSource.getParcelas());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ParcelaDetailEntity>> getParcelaById(int id) async {
    try {
      return Right(await _dataSource.getParcelaById(id));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
