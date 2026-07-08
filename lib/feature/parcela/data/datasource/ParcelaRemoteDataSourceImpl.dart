import '../../domain/entities/ParcelaEntity.dart';
import '../../domain/entities/ParcelaDetailEntity.dart';
import 'ParcelaRemoteDataSource.dart';

class ParcelaRemoteDataSourceImpl implements ParcelaRemoteDataSource {
  static const _parcelas = [
    ParcelaEntity(id: 1, name: 'Bloque A', hectares: 12, nodes: 4, status: 'saludable', lastReading: 'hace 2 min', healthPct: 0.88),
    ParcelaEntity(id: 2, name: 'Bloque B', hectares: 8,  nodes: 3, status: 'advertencia', lastReading: 'hace 18 min', healthPct: 0.55),
    ParcelaEntity(id: 3, name: 'Bloque C', hectares: 15, nodes: 5, status: 'critico',    lastReading: 'hace 2 h',    healthPct: 0.22),
    ParcelaEntity(id: 4, name: 'Bloque D', hectares: 6,  nodes: 2, status: 'saludable', lastReading: 'hace 3 min',  healthPct: 0.91),
  ];

  static final _details = {
    1: const ParcelaDetailEntity(
      id: 1, name: 'Bloque A', hectares: 12, nodes: 4,
      location: 'Loreto', status: 'saludable',
      humidity: 78, temperature: 34, phSoil: 6.4, solarLux: 842,
      humidityHistory: [72,74,75,73,76,78,80,82,81,79,77,76,78,80,82,83,82,80,78,79,80,81,78,77],
      lastSync: 'hace 2 min',
    ),
    2: const ParcelaDetailEntity(
      id: 2, name: 'Bloque B', hectares: 8, nodes: 3,
      location: 'Loreto', status: 'advertencia',
      humidity: 62, temperature: 36, phSoil: 5.8, solarLux: 620,
      humidityHistory: [68,66,64,62,60,58,60,62,63,64,62,60,58,56,58,60,62,63,61,59,58,60,62,62],
      lastSync: 'hace 18 min',
    ),
    3: const ParcelaDetailEntity(
      id: 3, name: 'Bloque C', hectares: 15, nodes: 5,
      location: 'Loreto', status: 'critico',
      humidity: 35, temperature: 38, phSoil: 4.9, solarLux: 1100,
      humidityHistory: [48,45,42,38,35,32,30,28,30,32,34,35,33,30,28,26,28,30,32,35,33,31,30,35],
      lastSync: 'hace 2 h',
    ),
    4: const ParcelaDetailEntity(
      id: 4, name: 'Bloque D', hectares: 6, nodes: 2,
      location: 'Loreto', status: 'saludable',
      humidity: 82, temperature: 33, phSoil: 6.7, solarLux: 780,
      humidityHistory: [80,81,82,83,82,81,80,82,83,84,83,82,81,80,81,82,83,84,83,82,81,80,82,82],
      lastSync: 'hace 3 min',
    ),
  };

  @override
  Future<List<ParcelaEntity>> getParcelas() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return _parcelas;
  }

  @override
  Future<ParcelaDetailEntity> getParcelaById(int id) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return _details[id] ?? _details[1]!;
  }
}
