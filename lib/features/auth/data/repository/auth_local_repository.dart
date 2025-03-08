// // complete xa

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/data/data_source/local_datasource/auth_local_datasource.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class AuthLocalRepository implements IAuthRepository {
  final AuthLocalDataSource _authLocalDataSource;

  AuthLocalRepository(this._authLocalDataSource);

  /// ✅ Get Current User (Local Storage)
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final currentUser = await _authLocalDataSource.getCurrentUser();
      return Right(currentUser);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Login User (Locally)
  @override
  Future<Either<Failure, String>> loginUser(
      String email, String password) async {
    try {
      final token = await _authLocalDataSource.loginUser(email, password);
      return Right(token);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Register User (Locally)
  @override
  Future<Either<Failure, void>> registerUser(AuthEntity entity) async {
    try {
      await _authLocalDataSource.registerUser(entity);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Upload Profile Picture (Locally - Placeholder)
  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imagePath = await _authLocalDataSource.uploadProfilePicture(file);
      return Right(imagePath);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Delete Profile Picture (Locally)
  @override
  Future<Either<Failure, void>> deleteProfilePicture() async {
    try {
      await _authLocalDataSource.deleteProfilePicture();
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Delete User (Locally)
  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await _authLocalDataSource.deleteUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Update Profile Picture (Locally)
  @override
  Future<Either<Failure, String>> updateProfilePicture(File file) async {
    try {
      final newImagePath =
          await _authLocalDataSource.updateProfilePicture(file);
      return Right(newImagePath);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Update User (Locally)
  @override
  Future<Either<Failure, void>> updateUser(
      AuthEntity entity, String token) async {
    try {
      await _authLocalDataSource.updateUser(entity, token);
      return const Right(null);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Get User by ID (Locally)
  @override
  Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
    try {
      final user = await _authLocalDataSource.getUserById(userId);
      return Right(user);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Get All Users (Locally)
  @override
  Future<Either<Failure, List<AuthEntity>>> getAllUsers() async {
    try {
      final users = await _authLocalDataSource.getAllUsers();
      return Right(users);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  /// ✅ Get Logged-in User (Locally)
  @override
  Future<Either<Failure, AuthEntity>> getMe() async {
    try {
      final authEntity = await _authLocalDataSource.getMe();
      return Right(authEntity);
    } catch (e) {
      return Left(LocalDatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> forgotPassword({String? email, String? phone}) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> resetPassword(
      {String? email,
      String? phone,
      required String otp,
      required String newPassword}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
