import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/AlertEntity.dart';
import '../../domain/usecases/GetAlertsUseCase.dart';

enum AlertStatus { initial, loading, loaded, error }

class AlertProvider extends ChangeNotifier {
  final GetAlertsUseCase _getUseCase;

  AlertProvider({required GetAlertsUseCase getAlertsUseCase})
      : _getUseCase = getAlertsUseCase;

  AlertStatus status = AlertStatus.initial;
  List<AlertEntity> _allAlerts = [];
  String errorMessage = '';

  String _selectedFilter = 'todas';
  String get selectedFilter => _selectedFilter;

  List<AlertEntity> get filteredAlerts => switch (_selectedFilter) {
    'criticas'    => _allAlerts.where((a) => a.level == 'crit').toList(),
    'advertencia' => _allAlerts.where((a) => a.level == 'warn').toList(),
    _             => _allAlerts,
  };

  void setFilter(String filter) {
    _selectedFilter = filter;
    notifyListeners();
  }

  Future<void> loadAlerts() async {
    if (status == AlertStatus.loading) return;
    status = AlertStatus.loading;
    notifyListeners();

    final result = await _getUseCase(const NoParams());
    result.fold(
          (failure) {
        status = AlertStatus.error;
        errorMessage = failure.message ?? 'Error al cargar alertas';
      },
          (data) {
        status = AlertStatus.loaded;
        _allAlerts = data;
      },
    );
    notifyListeners();
  }
}
