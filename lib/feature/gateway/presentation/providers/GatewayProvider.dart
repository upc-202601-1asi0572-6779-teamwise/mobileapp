import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/EdgeGatewayEntity.dart';
import '../../domain/entities/IotDeviceEntity.dart';
import '../../domain/entities/SensorReadingEntity.dart';
import '../../domain/usecases/GetDeviceReadingsUseCase.dart';
import '../../domain/usecases/GetGatewayDevicesUseCase.dart';
import '../../domain/usecases/GetMyGatewaysUseCase.dart';

enum LoadStatus { initial, loading, loaded, error }

class GatewayProvider extends ChangeNotifier {
  final GetMyGatewaysUseCase _getGatewaysUseCase;
  final GetGatewayDevicesUseCase _getDevicesUseCase;
  final GetDeviceReadingsUseCase _getReadingsUseCase;

  GatewayProvider({
    required GetMyGatewaysUseCase getMyGatewaysUseCase,
    required GetGatewayDevicesUseCase getGatewayDevicesUseCase,
    required GetDeviceReadingsUseCase getDeviceReadingsUseCase,
  })  : _getGatewaysUseCase = getMyGatewaysUseCase,
        _getDevicesUseCase = getGatewayDevicesUseCase,
        _getReadingsUseCase = getDeviceReadingsUseCase;

  // ── Gateways (lista "mis edge gateways") ──────────────────────────
  LoadStatus gatewaysStatus = LoadStatus.initial;
  List<EdgeGatewayEntity> gateways = [];
  String gatewaysError = '';

  Future<void> loadGateways() async {
    gatewaysStatus = LoadStatus.loading;
    notifyListeners();

    final result = await _getGatewaysUseCase(const NoParams());
    result.fold(
      (failure) {
        gatewaysStatus = LoadStatus.error;
        gatewaysError = failure.message ?? 'Error al cargar los edge gateways';
      },
      (data) {
        gatewaysStatus = LoadStatus.loaded;
        gateways = data;
      },
    );
    notifyListeners();
  }

  // ── Dispositivos IoT de un gateway seleccionado ───────────────────
  LoadStatus devicesStatus = LoadStatus.initial;
  List<IotDeviceEntity> devices = [];
  String devicesError = '';

  Future<void> loadDevices(String gatewayMac) async {
    devicesStatus = LoadStatus.loading;
    notifyListeners();

    final result = await _getDevicesUseCase(GatewayMacParams(gatewayMac));
    result.fold(
      (failure) {
        devicesStatus = LoadStatus.error;
        devicesError = failure.message ?? 'Error al cargar los dispositivos';
      },
      (data) {
        devicesStatus = LoadStatus.loaded;
        devices = data;
      },
    );
    notifyListeners();
  }

  // ── Lecturas de sensores de un dispositivo seleccionado ───────────
  LoadStatus readingsStatus = LoadStatus.initial;
  List<SensorReadingEntity> readings = [];
  String readingsError = '';

  Future<void> loadReadings(String deviceMac) async {
    readingsStatus = LoadStatus.loading;
    notifyListeners();

    final result = await _getReadingsUseCase(DeviceMacParams(deviceMac));
    result.fold(
      (failure) {
        readingsStatus = LoadStatus.error;
        readingsError = failure.message ?? 'Error al cargar las lecturas';
      },
      (data) {
        readingsStatus = LoadStatus.loaded;
        // Más reciente primero
        readings = [...data]..sort((a, b) => b.measuredAt.compareTo(a.measuredAt));
      },
    );
    notifyListeners();
  }
}
