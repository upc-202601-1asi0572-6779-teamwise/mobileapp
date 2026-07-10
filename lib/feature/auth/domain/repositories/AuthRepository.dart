import 'package:dartz/dartz.dart';
import '../../../core/error/Failure.dart';
import '../entities/AuthUserEntity.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUserEntity>> signIn({
    required String username,
    required String password,
  });
}
