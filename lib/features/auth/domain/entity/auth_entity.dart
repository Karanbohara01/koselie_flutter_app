import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  final String? userId;
  final String username;
  final String email;
  final String password;
  final String? image;

  // Create named constructor

  const AuthEntity(
      {required this.username,
      required this.email,
      required this.password,
      this.userId,
      this.image});

  // From Json
  factory AuthEntity.fromJson(Map<String, dynamic> json) {
    return AuthEntity(
        username: json['username'] as String,
        email: json['email'] as String,
        image: json['image'] as String?,
        password: json['password'] as String);
  }

  //  create empty constructor
  const AuthEntity.empty()
      : userId = "_empty.userId",
        email = "_empty.email",
        password = "_empty.password",
        image = "_empty.image",
        username = "_empty.username";

  @override
  List<Object?> get props => [userId, username, email, password, image];
}

// Complete xa
