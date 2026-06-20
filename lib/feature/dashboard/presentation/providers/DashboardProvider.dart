import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/DashboardSummaryEntity.dart';
import '../../domain/usecases/GetDashboardSummaryUseCase.dart';

enum DashboardStatus { initial, loading, loaded, error }

class DashboardProvider extends ChangeNotifier {
  final GetDashboardSummaryUseCase _getUseCase;

  DashboardProvider({required GetDashboardSummaryUseCase getDashboardSummaryUseCase})
      : _getUseCase = getDashboardSummaryUseCase;

  DashboardStatus status = DashboardStatus.initial;
  DashboardSummaryEntity? summary;
  String errorMessage = '';

  Future<void> loadDashboard() async {
    if (status == DashboardStatus.loading) return;
    status = DashboardStatus.loading;
    notifyListeners();

    final result = await _getUseCase(const NoParams());
    result.fold(
      (failure) {
        status = DashboardStatus.error;
        errorMessage = failure.message ?? 'Error al cargar el dashboard';
      },
      (data) {
        status = DashboardStatus.loaded;
        summary = data;
      },
    );
    notifyListeners();
  }
}
