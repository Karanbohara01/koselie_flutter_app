import 'dart:io';

import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthDataSource {
  Future<String> loginUser(String username, String password);

  Future<void> registerUser(AuthEntity entity);

  Future<AuthEntity> getCurrentUser();

  Future<String> uploadProfilePicture(File file);

  Future<void> deleteProfilePicture();

  Future<void> deleteUser(String userId);

  Future<String> updateProfilePicture(File file);

  Future<void> updateUser(AuthEntity entity, String token);

  Future<AuthEntity> getUserById(String userId);

  Future<List<AuthEntity>> getAllUsers();
  Future<AuthEntity> getMe(); // ✅ Fetch user details from API

  // New methods for OTP-based forgot and reset password
  Future<void> forgotPassword({String? email, String? phone});

  Future<void> resetPassword({
    String? email,
    String? phone,
    required String otp,
    required String newPassword,
  });
}
