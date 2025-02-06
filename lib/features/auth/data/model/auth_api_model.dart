import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

part 'auth_api_model.g.dart';

@JsonSerializable()
class AuthApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? userId;
  final String username;
  final String email;
  final String? password;
  final String? image;

  const AuthApiModel({
    this.userId,
    required this.image,
    required this.username,
    required this.email,
    required this.password,
  });

  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  // To Entity
  AuthEntity toEntity() {
    return AuthEntity(
      userId: userId,
      image: image,
      email: email,
      username: username,
      password: password ?? '',
    );
  }

  // From Entity
  factory AuthApiModel.fromEntity(AuthEntity entity) {
    return AuthApiModel(
      image: entity.image,
      email: entity.email,
      username: entity.username,
      password: entity.password,
    );
  }

  @override
  List<Object?> get props => [userId, image, password, email];
}
