import 'package:flutter/material.dart';
import '../../../core/usecases/UseCase.dart';
import '../../domain/entities/ProfileEntity.dart';
import '../../domain/usecases/GetProfileUseCase.dart';

enum ProfileStatus { initial, loading, loaded, error }

class ProfileProvider extends ChangeNotifier {
  final GetProfileUseCase _getUseCase;

  ProfileProvider({required GetProfileUseCase getProfileUseCase})
      : _getUseCase = getProfileUseCase;

  ProfileStatus status = ProfileStatus.initial;
  ProfileEntity? profile;
  String errorMessage = '';

  Future<void> loadProfile() async {
    if (status == ProfileStatus.loading) return;
    status = ProfileStatus.loading;
    notifyListeners();

    final result = await _getUseCase(const NoParams());
    result.fold(
      (failure) {
        status = ProfileStatus.error;
        errorMessage = failure.message ?? 'Error al cargar perfil';
      },
      (data) {
        status = ProfileStatus.loaded;
        profile = data;
      },
    );
    notifyListeners();
  }

  void logout(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (_) => false);
  }
}
