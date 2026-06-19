import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/SensorEntity.dart';
import '../../domain/usecases/GetSensorsUseCase.dart';

enum SensorStatus { initial, loading, loaded, error }

class SensorProvider extends ChangeNotifier {
  final GetSensorsUseCase _getUseCase;

  SensorProvider({required GetSensorsUseCase getSensorsUseCase})
      : _getUseCase = getSensorsUseCase;

  SensorStatus status = SensorStatus.initial;
  List<SensorEntity> sensors = [];
  String errorMessage = '';

  int get activeCount  => sensors.where((s) => s.status == 'activo').length;
  int get offlineCount => sensors.where((s) => s.status == 'sinsenal').length;

  Future<void> loadSensors() async {
    if (status == SensorStatus.loading) return;
    status = SensorStatus.loading;
    notifyListeners();

    final result = await _getUseCase(const NoParams());
    result.fold(
      (failure) {
        status = SensorStatus.error;
        errorMessage = failure.message ?? 'Error al cargar sensores';
      },
      (data) {
        status = SensorStatus.loaded;
        sensors = data;
      },
    );
    notifyListeners();
  }
}
