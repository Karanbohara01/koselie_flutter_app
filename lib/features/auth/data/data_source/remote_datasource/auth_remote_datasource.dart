import 'dart:io';

import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/app/shared_prefs/token_shared_prefs.dart';
import 'package:koselie/features/auth/data/data_source/auth_data_source.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  final TokenSharedPrefs _tokenSharedPrefs; // ✅ Inject TokenSharedPrefs

  AuthRemoteDatasource(this._dio, this._tokenSharedPrefs);
  @override
  Future<AuthEntity> getMe() async {
    try {
      // Retrieve token
      final tokenResult = await _tokenSharedPrefs.getToken();

      return tokenResult.fold(
        (failure) =>
            throw Exception("Failed to retrieve token: ${failure.message}"),
        (token) async {
          if (token == null || token.isEmpty) {
            throw Exception("No authentication token found");
          }

          print("🔹 Retrieved Token: $token"); // ✅ Log token before request

          Response response = await _dio.get(
            ApiEndpoints.getMe,
            options: Options(
              headers: {
                "Authorization": "Bearer $token", // ✅ Ensure token is attached
                "Accept": "application/json",
                "Content-Type": "application/json",
              },
            ),
          );

          if (response.statusCode == 200) {
            final data = response.data;
            return AuthEntity.fromJson(data);
          } else {
            throw Exception("Error: ${response.statusMessage}");
          }
        },
      );
    } on DioException catch (e) {
      print("❌ DioException: ${e.toString()}");
      throw Exception("Failed to fetch user data: ${e.toString()}");
    } catch (e) {
      print("❌ Unexpected Error: ${e.toString()}");
      throw Exception("An unexpected error occurred: ${e.toString()}");
    }
  }

  @override
  Future<AuthEntity> getCurrentUser() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getCurrentUser);

      if (response.statusCode == 200) {
        // Assuming the response data is a map representing the AuthEntity
        final data = response.data;
        final authEntity = AuthEntity.fromJson(data);
        return authEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> loginUser(String username, String password) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints.login,
        data: {
          "username": username,
          "password": password,
        },
      );

      if (response.statusCode == 200) {
        final str = response.data['token'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> registerUser(AuthEntity entity) async {
    try {
      Response response = await _dio.post(ApiEndpoints.register, data: {
        "username": entity.username,
        "email": entity.email,
        "password": entity.password,
        "image": entity.image,
      });
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> uploadProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.post(
        ApiEndpoints.uploadImage,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Extract the image name from the response
        final str = response.data['data'];

        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteProfilePicture() async {
    try {
      Response response = await _dio.delete(ApiEndpoints.deleteProfilePicture);

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      Response response = await _dio.delete(
          '${ApiEndpoints.deleteUser}/$userId'); // Append userId to the endpoint

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<String> updateProfilePicture(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'profilePicture': await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          ),
        },
      );

      Response response = await _dio.put(
        ApiEndpoints.updateProfilePicture,
        data: formData,
      );

      if (response.statusCode == 200) {
        final str = response.data['data'];
        return str;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> updateUser(AuthEntity entity, String? token) async {
    try {
      final response = await _dio.post(
        // ✅ Using POST as required
        "http://10.0.2.2:8000/api/v1/user/profile/edit",
        data: {
          "username": entity.username,
          "bio": entity.bio,
          "role": entity.role,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token", // ✅ Follow deleteCategory pattern
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<AuthEntity> getUserById(String userId) async {
    try {
      Response response = await _dio.get(
          '${ApiEndpoints.getUserById}/$userId'); // Append userId to the endpoint

      if (response.statusCode == 200) {
        final data = response.data;
        final authEntity = AuthEntity.fromJson(data);
        return authEntity;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<AuthEntity>> getAllUsers() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getAllUsers);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data is List
            ? response.data // ✅ Case 1: If API returns a direct list
            : response.data['users'] ??
                []; // ✅ Case 2: If API wraps users in a key

        return data
            .map((item) => AuthEntity.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception("Failed to fetch users: ${response.statusMessage}");
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data["message"] ?? "Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Unexpected Error: $e");
    }
  }

  @override
  Future<void> forgotPassword({String? email, String? phone}) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints
            .forgotPassword, // Ensure this endpoint is defined, e.g. "/api/v1/users/forgot-password"
        data: {
          'email': email,
          'phone': phone,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> resetPassword(
      {String? email,
      String? phone,
      required String otp,
      required String newPassword}) async {
    try {
      Response response = await _dio.post(
        ApiEndpoints
            .resetPassword, // Ensure this endpoint is defined, e.g. "/api/v1/users/reset-password"
        data: {
          'email': email,
          'phone': phone,
          'otp': otp,
          'newPassword': newPassword,
        },
      );

      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(response.statusMessage);
      }
    } on DioException catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception(e);
    }
  }
}
