import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/ReportEntity.dart';
import '../../domain/usecases/GetReportsUseCase.dart';
import '../../domain/usecases/GenerateReportUseCase.dart';

enum ReportStatus { initial, loading, loaded, error }
enum GenerateStatus { idle, generating, done, error }

class ReportProvider extends ChangeNotifier {
  final GetReportsUseCase _getUseCase;
  final GenerateReportUseCase _generateUseCase;

  ReportProvider({
    required GetReportsUseCase getReportsUseCase,
    required GenerateReportUseCase generateReportUseCase,
  })  : _getUseCase = getReportsUseCase,
        _generateUseCase = generateReportUseCase;

  ReportStatus status = ReportStatus.initial;
  GenerateStatus generateStatus = GenerateStatus.idle;
  List<ReportEntity> reports = [];
  String errorMessage = '';

  Future<void> loadReports() async {
    if (status == ReportStatus.loading) return;
    status = ReportStatus.loading;
    notifyListeners();

    final result = await _getUseCase(const NoParams());
    result.fold(
          (failure) {
        status = ReportStatus.error;
        errorMessage = failure.message ?? 'Error al cargar reportes';
      },
          (data) {
        status = ReportStatus.loaded;
        reports = data;
      },
    );
    notifyListeners();
  }

  Future<void> generateReport(ReportType type, {int? blockId}) async {
    generateStatus = GenerateStatus.generating;
    notifyListeners();

    final result = await _generateUseCase(GenerateReportParams(type: type, blockId: blockId));
    result.fold(
          (failure) {
        generateStatus = GenerateStatus.error;
        errorMessage = failure.message ?? 'Error al generar reporte';
      },
          (newReport) {
        generateStatus = GenerateStatus.done;
        reports = [newReport, ...reports];
      },
    );
    notifyListeners();
  }
}
