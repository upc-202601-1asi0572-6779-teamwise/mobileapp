import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/ParcelaEntity.dart';
import '../../domain/entities/ParcelaDetailEntity.dart';
import 'ParcelaRemoteDataSource.dart';

class ParcelaHttpDataSourceImpl implements ParcelaRemoteDataSource {
  @override
  Future<List<ParcelaEntity>> getParcelas() async {
    final data = await ApiClient.get('/parcelas') as List;
    return data.map((e) => ParcelaEntity.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<ParcelaDetailEntity> getParcelaById(int id) async {
    final data = await ApiClient.get('/parcelas/$id');
    return ParcelaDetailEntity.fromJson(data as Map<String, dynamic>);
  }
}
