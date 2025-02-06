import 'dart:io';

import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity entity);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);
}
