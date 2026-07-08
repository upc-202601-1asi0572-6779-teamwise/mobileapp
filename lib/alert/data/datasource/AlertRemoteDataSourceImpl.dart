import '../../domain/entities/AlertEntity.dart';
import 'AlertRemoteDataSource.dart';

class AlertRemoteDataSourceImpl implements AlertRemoteDataSource {
  @override
  Future<List<AlertEntity>> getAlerts() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return const [
      AlertEntity(id: 1, level: 'crit', title: 'Estrés hídrico – Bloque C', block: 'Bloque C', timeAgo: 'hace 2 min'),
      AlertEntity(id: 2, level: 'warn', title: 'Minador de hoja detectado',  block: 'Bloque A', timeAgo: 'hace 18 min'),
      AlertEntity(id: 3, level: 'info', title: 'pH bajo – posible acidez',   block: 'Bloque B', timeAgo: 'hace 1 h'),
      AlertEntity(id: 4, level: 'warn', title: 'Temperatura alta (38°C)',    block: 'Bloque D', timeAgo: 'hace 3 h'),
      AlertEntity(id: 5, level: 'ok',   title: 'Sincronización · 12 nodos OK', timeAgo: 'hace 5 h'),
    ];
  }
}
