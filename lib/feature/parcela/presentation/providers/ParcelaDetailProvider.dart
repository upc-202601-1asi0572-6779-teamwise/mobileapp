import 'package:flutter/material.dart';
import '../../domain/entities/ParcelaDetailEntity.dart';
import '../../domain/usecases/GetParcelaByIdUseCase.dart';

enum ParcelaDetailStatus { initial, loading, loaded, error }

class ParcelaDetailProvider extends ChangeNotifier {
  final GetParcelaByIdUseCase _getByIdUseCase;

  ParcelaDetailProvider({required GetParcelaByIdUseCase getParcelaByIdUseCase})
      : _getByIdUseCase = getParcelaByIdUseCase;

  ParcelaDetailStatus status = ParcelaDetailStatus.initial;
  ParcelaDetailEntity? detail;
  String errorMessage = '';

  Future<void> loadDetail(int parcelaId) async {
    status = ParcelaDetailStatus.loading;
    notifyListeners();

    final result = await _getByIdUseCase(GetParcelaByIdParams(parcelaId));
    result.fold(
          (failure) {
        status = ParcelaDetailStatus.error;
        errorMessage = failure.message ?? 'Error al cargar parcela';
      },
          (data) {
        status = ParcelaDetailStatus.loaded;
        detail = data;
      },
    );
    notifyListeners();
  }
}
