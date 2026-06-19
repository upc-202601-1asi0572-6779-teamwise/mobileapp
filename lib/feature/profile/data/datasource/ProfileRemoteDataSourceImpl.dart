import '../../domain/entities/ProfileEntity.dart';
import 'ProfileRemoteDataSource.dart';

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  @override
  Future<ProfileEntity> getProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const ProfileEntity(
      name: 'Carlos Ríos',
      initials: 'CR',
      farm: 'Fundo Las Palmas',
      location: 'Loreto',
      plan: 'Plan 🌾 Cosecha',
      totalHectares: 41,
      totalSensors: 14,
      totalParcelas: 3,
    );
  }
}
