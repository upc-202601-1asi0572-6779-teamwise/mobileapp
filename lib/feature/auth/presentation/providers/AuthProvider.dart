import 'package:flutter/material.dart';
import '../../../../core/network/ApiClient.dart';
import '../../../../core/session/SessionStorage.dart';
import '../../domain/usecases/SignInUseCase.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthProvider extends ChangeNotifier {
  final SignInUseCase _signInUseCase;
  final SessionStorage _sessionStorage;

  AuthProvider({
    required SignInUseCase signInUseCase,
    required SessionStorage sessionStorage,
  })  : _signInUseCase = signInUseCase,
        _sessionStorage = sessionStorage;

  AuthStatus status = AuthStatus.initial;
  int? userId;
  String? username;
  String? email;
  String? fullName;
  String? role;
  String errorMessage = '';

  /// Restaura la sesión guardada (si existe) al arrancar la app.
  Future<void> restoreSession() async {
    final token = await _sessionStorage.readToken();
    final savedUsername = await _sessionStorage.readUsername();
    if (token != null && savedUsername != null) {
      ApiClient.authToken = token;
      username = savedUsername;
      userId = await _sessionStorage.readUserId();
      email = await _sessionStorage.readEmail();
      fullName = await _sessionStorage.readFullName();
      role = await _sessionStorage.readRole();
      status = AuthStatus.authenticated;
    } else {
      status = AuthStatus.unauthenticated;
    }
    notifyListeners();
  }

  Future<bool> signIn({required String username, required String password}) async {
    status = AuthStatus.loading;
    notifyListeners();

    final result = await _signInUseCase(
      SignInParams(username: username, password: password),
    );

    var success = false;
    result.fold(
      (failure) {
        status = AuthStatus.error;
        errorMessage = failure.message ?? 'Usuario o contraseña incorrectos';
      },
      (user) {
        ApiClient.authToken = user.token;
        userId = user.id;
        this.username = user.username;
        email = user.email;
        fullName = user.fullName;
        role = user.role;
        status = AuthStatus.authenticated;
        _sessionStorage.save(
          token: user.token,
          username: user.username,
          userId: user.id,
          email: user.email,
          fullName: user.fullName,
          role: user.role,
        );
        success = true;
      },
    );

    notifyListeners();
    return success;
  }

  Future<void> signOut() async {
    ApiClient.authToken = null;
    userId = null;
    username = null;
    email = null;
    fullName = null;
    role = null;
    status = AuthStatus.unauthenticated;
    await _sessionStorage.clear();
    notifyListeners();
  }
}
