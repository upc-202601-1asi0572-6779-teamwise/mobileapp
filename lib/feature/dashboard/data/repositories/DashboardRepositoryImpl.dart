import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/DashboardSummaryEntity.dart';
import '../../domain/repositories/DashboardRepository.dart';
import '../datasource/DashboardRemoteDataSource.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource _dataSource;

  DashboardRepositoryImpl({required DashboardRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, DashboardSummaryEntity>> getDashboardSummary() async {
    try {
      return Right(await _dataSource.getDashboardSummary());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
