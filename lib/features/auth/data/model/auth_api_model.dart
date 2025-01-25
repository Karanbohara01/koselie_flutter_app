import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? userId;
  final String username;
  final String email;
  final String password;

  const AuthApiModel({
    this.userId,
    required this.username,
    required this.email,
    required this.password,
  });

  const AuthApiModel.empty()
      : userId = '',
        username = '',
        password = '',
        email = '';

  factory AuthApiModel.fromJson(Map<String, dynamic> json) {
    return AuthApiModel(
      userId: json['_id'],
      username: json['username'],
      password: json['password'],
      email: json['email'],
    );
  }
  // To json
  Map<String, dynamic> toJson() {
    return {
      '_id': userId,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  // Convert API object to Entity
  AuthEntity toEntity() => AuthEntity(
      email: email, userId: userId, username: username, password: password);

// Convert entity to API object
  static AuthApiModel fromEntity(AuthEntity entity) => AuthApiModel(
      username: entity.username,
      email: entity.email,
      password: entity.password);

  // Convert API list to entity list
  static List<AuthEntity> toEntityList(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [userId, username, password, email];
}
