import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/PlantationEntity.dart';
import '../../domain/entities/SectorEntity.dart';
import 'PlantationRemoteDataSource.dart';

class PlantationHttpDataSourceImpl implements PlantationRemoteDataSource {
  @override
  Future<List<PlantationEntity>> getMyPlantations() async {
    final data = await ApiClient.get('/api/v1/plantations') as List;
    return data
        .map((e) => PlantationEntity.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PlantationDetailEntity> getPlantationDetail(int plantationId) async {
    final data = await ApiClient.get('/api/v1/plantations/$plantationId') as Map<String, dynamic>;
    return PlantationDetailEntity.fromJson(data);
  }
}
