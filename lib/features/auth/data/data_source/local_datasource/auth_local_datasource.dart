import 'dart:io';

import 'package:koselie/core/network/hive_service.dart';
import 'package:koselie/features/auth/data/data_source/auth_data_source.dart';
import 'package:koselie/features/auth/data/model/auth_hive_model.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

class AuthLocalDataSource implements IAuthDataSource {
  final HiveService _hiveService;
  AuthLocalDataSource(this._hiveService);
  @override
  Future<AuthEntity> getCurrentUser() {
    // return empty authentity
    return Future.value(const AuthEntity(
      userId: "1",
      email: "",
      username: "",
      password: "",
    ));
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      await _hiveService.loginUser(username, password);
      return Future.value("Success");
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity entity) async {
    try {
      // Convert AuthEntity to AuthHiveModel
      final authHiveModel = AuthHiveModel.fromEntity(entity);

      await _hiveService.registerUser(authHiveModel);
      return Future.value();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) {
    // TODO: implement uploadProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProfilePicture() {
    // TODO: implement deleteProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String userId) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<String> updateProfilePicture(File file) {
    // TODO: implement updateProfilePicture
    throw UnimplementedError();
  }

  @override
  Future<void> updateUser(AuthEntity entity, String token) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> getUserById(String userId) {
    // TODO: implement getUserById
    throw UnimplementedError();
  }

  @override
  Future<List<AuthEntity>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<AuthEntity> getMe() {
    // TODO: implement getMe
    throw UnimplementedError();
  }

  //   @override
  // Future<String> uploadProfilePicture(File file) {
  //   throw UnimplementedError();
  // }
}
