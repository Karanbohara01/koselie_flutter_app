import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:koselie/app/constants/hive_table_constant.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:uuid/uuid.dart';

@HiveType(typeId: HiveTableConstant.authTableId)
class AuthHiveModel extends Equatable {
  @HiveField(0)
  final String? userId;

  @HiveField(1)
  final String userName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  // Main Constructor
  AuthHiveModel({
    String? userId,
    required this.email,
    required this.userName,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  // Initial Constructor
  // Creates an instance with default empty values

  const AuthHiveModel.initial()
      : userId = '',
        userName = '',
        password = '',
        email = '';

  // Convert AuthEntity into Auth Hive Model
  factory AuthHiveModel.fromEntity(AuthEntity entity) {
    return AuthHiveModel(
      email: entity.email,
      userName: entity.userName,
      password: entity.password,
    );
  }

  // Convert AuthHiveModel back to AuthEntity
  AuthEntity toEntity() {
    return AuthEntity(userName: userName, email: email, password: password);
  }

  @override
  List<Object?> get props => [userId];
}