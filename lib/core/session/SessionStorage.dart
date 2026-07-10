import 'package:shared_preferences/shared_preferences.dart';

/// Persistencia simple de la sesión activa (JWT + username) usando
/// shared_preferences. No es almacenamiento seguro cifrado — suficiente
/// para el alcance académico del proyecto.
class SessionStorage {
  static const _tokenKey = 'auth_token';
  static const _usernameKey = 'auth_username';
  static const _userIdKey = 'auth_user_id';
  static const _emailKey = 'auth_email';
  static const _fullNameKey = 'auth_full_name';
  static const _roleKey = 'auth_role';

  Future<void> save({
    required String token,
    required String username,
    required int userId,
    String? email,
    String? fullName,
    String? role,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    await prefs.setString(_usernameKey, username);
    await prefs.setInt(_userIdKey, userId);
    if (email != null) {
      await prefs.setString(_emailKey, email);
    } else {
      await prefs.remove(_emailKey);
    }
    if (fullName != null) {
      await prefs.setString(_fullNameKey, fullName);
    } else {
      await prefs.remove(_fullNameKey);
    }
    if (role != null) {
      await prefs.setString(_roleKey, role);
    } else {
      await prefs.remove(_roleKey);
    }
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> readUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  Future<int?> readUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIdKey);
  }

  Future<String?> readEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  Future<String?> readFullName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_fullNameKey);
  }

  Future<String?> readRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_roleKey);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_usernameKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_emailKey);
    await prefs.remove(_fullNameKey);
    await prefs.remove(_roleKey);
  }
}
