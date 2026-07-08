import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/ParcelaEntity.dart';
import '../../domain/usecases/GetParcelasUseCase.dart';

enum ParcelaStatus { initial, loading, loaded, error }

class ParcelaProvider extends ChangeNotifier {
  final GetParcelasUseCase _getUseCase;

  ParcelaProvider({required GetParcelasUseCase getParcelasUseCase})
      : _getUseCase = getParcelasUseCase;

  ParcelaStatus status = ParcelaStatus.initial;
  List<ParcelaEntity> parcelas = [];
  String errorMessage = '';

  Future<void> loadParcelas() async {
    if (status == ParcelaStatus.loading) return;
    status = ParcelaStatus.loading;
    notifyListeners();

    final result = await _getUseCase(const NoParams());
    result.fold(
          (failure) {
        status = ParcelaStatus.error;
        errorMessage = failure.message ?? 'Error al cargar parcelas';
      },
          (data) {
        status = ParcelaStatus.loaded;
        parcelas = data;
      },
    );
    notifyListeners();
  }
}
