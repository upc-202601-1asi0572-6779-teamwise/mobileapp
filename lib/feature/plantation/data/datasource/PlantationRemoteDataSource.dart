import '../../domain/entities/PlantationEntity.dart';
import '../../domain/entities/SectorEntity.dart';

abstract class PlantationRemoteDataSource {
  Future<List<PlantationEntity>> getMyPlantations();
  Future<PlantationDetailEntity> getPlantationDetail(int plantationId);
}
