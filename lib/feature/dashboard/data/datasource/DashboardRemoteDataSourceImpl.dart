import '../../domain/entities/DashboardSummaryEntity.dart';
import 'DashboardRemoteDataSource.dart';

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<DashboardSummaryEntity> getDashboardSummary() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const DashboardSummaryEntity(
      farmerName: 'Carlos',
      farmName: 'Fundo Las Palmas',
      location: 'Loreto, Perú',
      humidity: 78,
      temperature: 34,
      phSoil: 6.4,
      isOnline: true,
      recentPlots: [
        PlotSummaryEntity(id: 1, name: 'Bloque A', hectares: 12, nodes: 4, status: 'saludable'),
        PlotSummaryEntity(id: 3, name: 'Bloque C', hectares: 15, nodes: 5, status: 'critico'),
      ],
      recentAlerts: [
        AlertSummaryEntity(level: 'crit', title: 'Estrés hídrico – Bloque C', block: 'Bloque C', timeAgo: 'hace 2 min'),
        AlertSummaryEntity(level: 'warn', title: 'Minador de hoja detectado', block: 'Bloque A', timeAgo: 'hace 18 min'),
        AlertSummaryEntity(level: 'info', title: 'pH bajo – posible acidez', block: 'Bloque B', timeAgo: 'hace 1 h'),
      ],
    );
  }
}
