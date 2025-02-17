// import 'package:dartz/dartz.dart';
// import 'package:koselie/core/error/failure.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class TokenSharedPrefs {
//   final SharedPreferences _sharedPreferences;

//   TokenSharedPrefs(this._sharedPreferences);

//   Future<Either<Failure, void>> saveToken(String token) async {
//     try {
//       await _sharedPreferences.setString('token', token);
//       return const Right(null);
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }

//   Future<Either<Failure, String>> getToken() async {
//     try {
//       final token = _sharedPreferences.getString('token');
//       return Right(token ?? '');
//     } catch (e) {
//       return Left(SharedPrefsFailure(message: e.toString()));
//     }
//   }
// }

import 'package:dartz/dartz.dart';
import 'package:koselie/core/error/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenSharedPrefs {
  final SharedPreferences _sharedPreferences;

  TokenSharedPrefs(this._sharedPreferences);

  /// Save token when user logs in
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      await _sharedPreferences.setString('token', token);
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  /// Retrieve stored token
  Future<Either<Failure, String?>> getToken() async {
    try {
      final token = _sharedPreferences.getString('token');
      return Right(token);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }

  /// Remove token on logout
  Future<Either<Failure, void>> removeToken() async {
    try {
      await _sharedPreferences.remove('token');
      return const Right(null);
    } catch (e) {
      return Left(SharedPrefsFailure(message: e.toString()));
    }
  }
}
