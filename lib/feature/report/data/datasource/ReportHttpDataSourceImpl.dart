import '../../../../core/network/ApiClient.dart';
import '../../domain/entities/ReportEntity.dart';
import 'ReportRemoteDataSource.dart';

class ReportHttpDataSourceImpl implements ReportRemoteDataSource {
  @override
  Future<List<ReportEntity>> getReports() async {
    final data = await ApiClient.get('/reports') as List;
    return data.map((e) => ReportEntity.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<ReportEntity> generateReport(ReportType type, {int? blockId}) async {
    final names = {
      ReportType.weekly: 'Reporte Semanal',
      ReportType.monthly: 'Reporte Mensual',
      ReportType.byBlock: 'Reporte Bloque ${blockId ?? ''}',
    };
    final data = await ApiClient.post('/reports', {
      'name': names[type]!,
      'type': 'PDF',
      'subtitle': 'Generado ahora',
      'createdAgo': 'hace 1 min',
    });
    return ReportEntity.fromJson(data as Map<String, dynamic>);
  }
}
