import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/AlertEntity.dart';
import '../../domain/repositories/AlertRepository.dart';
import '../datasource/AlertRemoteDataSource.dart';

class AlertRepositoryImpl implements AlertRepository {
  final AlertRemoteDataSource _dataSource;

  AlertRepositoryImpl({required AlertRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<AlertEntity>>> getAlerts() async {
    try {
      return Right(await _dataSource.getAlerts());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
