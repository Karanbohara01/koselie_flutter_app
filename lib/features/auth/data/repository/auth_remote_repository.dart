// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:koselie/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
// import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

// class AuthRemoteRepository implements IAuthRepository {
//   final AuthRemoteDatasource _authRemoteDatasource;

//   AuthRemoteRepository(this._authRemoteDatasource);
//   @override
//   Future<Either<Failure, AuthEntity>> getCurrentUser() async {
//     try {
//       final authEntity = await _authRemoteDatasource.getCurrentUser();
//       return Right(authEntity);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> loginUser(
//     String username,
//     String password,
//   ) async {
//     try {
//       final token = await _authRemoteDatasource.loginUser(username, password);
//       return Right(token);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> registerUser(AuthEntity entity) async {
//     try {
//       _authRemoteDatasource.registerUser(entity);
//       return const Right(null);
//     } catch (e) {
//       return Left(
//         ApiFailure(
//           message: e.toString(),
//         ),
//       );
//     }
//   }

//   @override
//   Future<Either<Failure, String>> uploadProfilePicture(File file) async {
//     try {
//       final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
//       return Right(imageName);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteProfilePicture() async {
//     try {
//       await _authRemoteDatasource.deleteProfilePicture();
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteUser(String userId) async {
//     try {
//       await _authRemoteDatasource.deleteUser(userId);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> updateProfilePicture(File file) async {
//     try {
//       final newImageUrl =
//           await _authRemoteDatasource.updateProfilePicture(file);
//       return Right(newImageUrl);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> updateUser(AuthEntity entity) async {
//     try {
//       await _authRemoteDatasource.updateUser(entity);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
//     try {
//       final authEntity = await _authRemoteDatasource.getUserById(userId);
//       return Right(authEntity);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, List<AuthEntity>>> getAllUsers() async {
//     try {
//       final authEntities = await _authRemoteDatasource.getAllUsers();
//       return Right(authEntities);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, AuthEntity>> getMe() async {
//     try {
//       final authEntity = await _authRemoteDatasource.getMe(); // ✅ Call API
//       return Right(authEntity);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString()));
//     }
//   }
// }

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:koselie/features/auth/data/data_source/remote_datasource/auth_remote_datasource.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';
import 'package:koselie/features/auth/domain/repository/auth_repository.dart';

class AuthRemoteRepository implements IAuthRepository {
  final AuthRemoteDatasource _authRemoteDatasource;

  AuthRemoteRepository(this._authRemoteDatasource);

  /// ✅ Fetch Current Logged-in User Profile
  @override
  Future<Either<Failure, AuthEntity>> getCurrentUser() async {
    try {
      final authEntity = await _authRemoteDatasource.getCurrentUser();
      return Right(authEntity);
    } on SocketException {
      return Left(NetworkFailure(message: "No Internet Connection"));
    } on HttpException {
      return Left(ServerFailure("Server error"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Login User
  @override
  Future<Either<Failure, String>> loginUser(
      String username, String password) async {
    try {
      final token = await _authRemoteDatasource.loginUser(username, password);
      return Right(token);
    } on SocketException {
      return Left(NetworkFailure(message: "No Internet Connection"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Register User
  @override
  Future<Either<Failure, void>> registerUser(AuthEntity entity) async {
    try {
      await _authRemoteDatasource.registerUser(entity);
      return const Right(null);
    } on SocketException {
      return Left(NetworkFailure(message: "No Internet Connection"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Upload Profile Picture
  @override
  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    try {
      final imageName = await _authRemoteDatasource.uploadProfilePicture(file);
      return Right(imageName);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Delete Profile Picture
  @override
  Future<Either<Failure, void>> deleteProfilePicture() async {
    try {
      await _authRemoteDatasource.deleteProfilePicture();
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Delete User
  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await _authRemoteDatasource.deleteUser(userId);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Update Profile Picture
  @override
  Future<Either<Failure, String>> updateProfilePicture(File file) async {
    try {
      final newImageUrl =
          await _authRemoteDatasource.updateProfilePicture(file);
      return Right(newImageUrl);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Update User Profile
  @override
  Future<Either<Failure, void>> updateUser(
      AuthEntity entity, String token) async {
    try {
      await _authRemoteDatasource.updateUser(entity, token);
      return const Right(null);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Fetch a Specific User by ID
  @override
  Future<Either<Failure, AuthEntity>> getUserById(String userId) async {
    try {
      final authEntity = await _authRemoteDatasource.getUserById(userId);
      return Right(authEntity);
    } on SocketException {
      return Left(NetworkFailure(message: "No Internet Connection"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Fetch All Users
  @override
  Future<Either<Failure, List<AuthEntity>>> getAllUsers() async {
    try {
      final authEntities = await _authRemoteDatasource.getAllUsers();
      return Right(authEntities);
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }

  /// ✅ Fetch My Profile
  @override
  Future<Either<Failure, AuthEntity>> getMe() async {
    try {
      final authEntity = await _authRemoteDatasource.getMe(); // ✅ Call API
      return Right(authEntity);
    } on SocketException {
      return Left(NetworkFailure(message: "No Internet Connection"));
    } catch (e) {
      return Left(ApiFailure(message: e.toString()));
    }
  }
}
