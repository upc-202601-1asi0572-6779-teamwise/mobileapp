import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/PlantationEntity.dart';
import '../../domain/entities/SectorEntity.dart';
import '../../domain/usecases/GetMyPlantationsUseCase.dart';
import '../../domain/usecases/GetPlantationDetailUseCase.dart';

enum LoadStatus { initial, loading, loaded, error }

class PlantationProvider extends ChangeNotifier {
  final GetMyPlantationsUseCase _getPlantationsUseCase;
  final GetPlantationDetailUseCase _getDetailUseCase;

  PlantationProvider({
    required GetMyPlantationsUseCase getMyPlantationsUseCase,
    required GetPlantationDetailUseCase getPlantationDetailUseCase,
  })  : _getPlantationsUseCase = getMyPlantationsUseCase,
        _getDetailUseCase = getPlantationDetailUseCase;

  LoadStatus plantationsStatus = LoadStatus.initial;
  List<PlantationEntity> plantations = [];
  String plantationsError = '';

  Future<void> loadPlantations() async {
    plantationsStatus = LoadStatus.loading;
    notifyListeners();

    final result = await _getPlantationsUseCase(const NoParams());
    result.fold(
      (failure) {
        plantationsStatus = LoadStatus.error;
        plantationsError = failure.message ?? 'Error al cargar las parcelas';
      },
      (data) {
        plantationsStatus = LoadStatus.loaded;
        plantations = data;
      },
    );
    notifyListeners();
  }

  LoadStatus detailStatus = LoadStatus.initial;
  PlantationDetailEntity? detail;
  String detailError = '';

  Future<void> loadDetail(int plantationId) async {
    detailStatus = LoadStatus.loading;
    notifyListeners();

    final result = await _getDetailUseCase(PlantationIdParams(plantationId));
    result.fold(
      (failure) {
        detailStatus = LoadStatus.error;
        detailError = failure.message ?? 'Error al cargar la parcela';
      },
      (data) {
        detailStatus = LoadStatus.loaded;
        detail = data;
      },
    );
    notifyListeners();
  }
}
