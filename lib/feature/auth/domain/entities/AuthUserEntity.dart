import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final int id;
  final String username;
  final String email;
  final String fullName;
  final String role;
  final String token;

  const AuthUserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.fullName,
    required this.role,
    required this.token,
  });

  factory AuthUserEntity.fromJson(Map<String, dynamic> json) => AuthUserEntity(
        id: json['id'] as int,
        username: json['username'] as String,
        email: json['email'] as String,
        fullName: json['fullName'] as String,
        role: json['role'] as String,
        token: json['token'] as String,
      );

  @override
  List<Object?> get props => [id, username, email, fullName, role, token];
}
