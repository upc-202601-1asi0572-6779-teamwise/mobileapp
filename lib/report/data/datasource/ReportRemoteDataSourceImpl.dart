import '../../domain/entities/ReportEntity.dart';
import 'ReportRemoteDataSource.dart';

class ReportRemoteDataSourceImpl implements ReportRemoteDataSource {
  @override
  Future<List<ReportEntity>> getReports() async {
    await Future.delayed(const Duration(milliseconds: 700));
    return const [
      ReportEntity(id: 1, name: 'Reporte Semana 19', type: 'PDF', subtitle: 'Fundo completo',     createdAgo: 'hace 2 días'),
      ReportEntity(id: 2, name: 'Reporte Bloque A',  type: 'PDF', subtitle: 'Bloque A · detalle', createdAgo: 'hace 5 días'),
      ReportEntity(id: 3, name: 'Mayo 2026 Export',  type: 'CSV', subtitle: 'Exportación mensual', createdAgo: 'hace 1 sem'),
    ];
  }

  @override
  Future<ReportEntity> generateReport(ReportType type, {int? blockId}) async {
    await Future.delayed(const Duration(milliseconds: 1200));
    final names = {
      ReportType.weekly:  'Reporte Semanal',
      ReportType.monthly: 'Reporte Mensual',
      ReportType.byBlock: blockId != null ? 'Reporte Bloque $blockId' : 'Reporte por Bloque',
    };
    return ReportEntity(
      id: DateTime.now().millisecondsSinceEpoch,
      name: names[type]!,
      type: 'PDF',
      subtitle: 'Generado ahora',
      createdAgo: 'hace 1 min',
    );
  }
}
