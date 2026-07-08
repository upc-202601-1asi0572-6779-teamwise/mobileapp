import 'package:dartz/dartz.dart';
import '../../../feature/core/error/Failure.dart';
import '../../domain/entities/ReportEntity.dart';
import '../../domain/repositories/ReportRepository.dart';
import '../datasource/ReportRemoteDataSource.dart';

class ReportRepositoryImpl implements ReportRepository {
  final ReportRemoteDataSource _dataSource;

  ReportRepositoryImpl({required ReportRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, List<ReportEntity>>> getReports() async {
    try {
      return Right(await _dataSource.getReports());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ReportEntity>> generateReport(ReportType type, {int? blockId}) async {
    try {
      return Right(await _dataSource.generateReport(type, blockId: blockId));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
