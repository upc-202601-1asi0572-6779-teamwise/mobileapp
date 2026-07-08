import '../../domain/entities/ParcelaEntity.dart';
import '../../domain/entities/ParcelaDetailEntity.dart';

abstract class ParcelaRemoteDataSource {
  Future<List<ParcelaEntity>> getParcelas();
  Future<ParcelaDetailEntity> getParcelaById(int id);
}
