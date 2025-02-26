import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, void>> registerUser(AuthEntity entity);
  Future<Either<Failure, String>> loginUser(String username, String password);
  Future<Either<Failure, String>> uploadProfilePicture(File file);
  Future<Either<Failure, AuthEntity>> getCurrentUser();
  Future<Either<Failure, void>> updateUser(
      AuthEntity entity, String token); // Assume you pass the updated entity
  Future<Either<Failure, void>> deleteUser(
      String userId); // Assuming you pass the userId
  // or  Future<Either<Failure, void>> deleteUser(AuthEntity entity);
  Future<Either<Failure, void>> deleteProfilePicture(); // No arguments needed

  Future<Either<Failure, String>> updateProfilePicture(
      File file); // Returns new image URL
  Future<Either<Failure, AuthEntity>> getUserById(String userId);
  Future<Either<Failure, List<AuthEntity>>> getAllUsers();

  Future<Either<Failure, AuthEntity>> getMe(); // ✅ Added getMe()

  Future<Either<Failure, void>> forgotPassword({String? email, String? phone});
  Future<Either<Failure, void>> resetPassword(
      {String? email,
      String? phone,
      required String otp,
      required String newPassword});
}
