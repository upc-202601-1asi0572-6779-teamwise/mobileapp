import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../../domain/entities/AuthUserEntity.dart';
import '../../domain/repositories/AuthRepository.dart';
import '../datasource/AuthRemoteDataSource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _dataSource;

  AuthRepositoryImpl({required AuthRemoteDataSource remoteDataSource})
      : _dataSource = remoteDataSource;

  @override
  Future<Either<Failure, AuthUserEntity>> signIn({
    required String username,
    required String password,
  }) async {
    try {
      return Right(await _dataSource.signIn(username: username, password: password));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
