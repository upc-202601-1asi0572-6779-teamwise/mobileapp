import '../../domain/entities/ProfileEntity.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileEntity> getProfile();
}
