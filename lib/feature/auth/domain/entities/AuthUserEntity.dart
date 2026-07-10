import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final int userId;
  final String username;
  final String? email;
  final String? fullName;
  final String? role;
  final String token;

  const AuthUserEntity({
    required this.userId,
    required this.username,
    this.email,
    this.fullName,
    this.role,
    required this.token,
  });

  factory AuthUserEntity.fromJson(Map<String, dynamic> json) => AuthUserEntity(
        userId: json['userId'] as int,
        username: json['username'] as String,
        email: json['email'] as String?,
        fullName: json['fullName'] as String?,
        role: json['role'] as String?,
        token: json['token'] as String,
      );

  @override
  List<Object?> get props => [userId, username, email, fullName, role, token];
}
