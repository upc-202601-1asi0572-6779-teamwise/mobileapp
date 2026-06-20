import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/ProfileEntity.dart';
import 'ProfileRemoteDataSource.dart';

class ProfileHttpDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileEntity> getProfile() async {
    final data = await ApiClient.get('/profile');
    return ProfileEntity.fromJson(data as Map<String, dynamic>);
  }
}
