import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String userName;
  final String email;
  final String password;
  // final String? image;

  // Create named constructor

  const AuthEntity({
    required this.userName,
    required this.email,
    required this.password,
    this.userId,
    // this.image
  });

  @override
  List<Object?> get props => [userId, userName, email, password];
}

// Complete xa
