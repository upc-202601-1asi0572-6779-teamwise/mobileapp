import '../../domain/entities/AuthUserEntity.dart';

abstract class AuthRemoteDataSource {
  Future<AuthUserEntity> signIn({required String username, required String password});
}
