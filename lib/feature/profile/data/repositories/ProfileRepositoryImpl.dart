import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/ProfileEntity.dart';
import '../../domain/repositories/ProfileRepository.dart';
import '../datasource/ProfileRemoteDataSource.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _dataSource;

  ProfileRepositoryImpl({required ProfileRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, ProfileEntity>> getProfile() async {
    try {
      return Right(await _dataSource.getProfile());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
