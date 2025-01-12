import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String userName;
  final String email;
  final String password;

  // Create named constructor

  const AuthEntity({
    required this.userName,
    required this.email,
    required this.password,
    this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
