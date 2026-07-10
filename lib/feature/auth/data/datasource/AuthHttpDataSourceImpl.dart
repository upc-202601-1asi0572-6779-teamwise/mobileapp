import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/AuthUserEntity.dart';
import 'AuthRemoteDataSource.dart';

class AuthHttpDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<AuthUserEntity> signIn({required String username, required String password}) async {
    final data = await ApiClient.post('/api/v1/authentication/sign-in', {
      'username': username,
      'password': password,
    }) as Map<String, dynamic>;
    return AuthUserEntity.fromJson(data);
  }
}
