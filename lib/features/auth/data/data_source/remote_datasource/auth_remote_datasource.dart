import 'dart:io';

import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/features/auth/data/data_source/auth_data_source.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDatasource(this._dio);
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
  Future<void> updateUser(AuthEntity entity) async {
    try {
      Response response = await _dio.put(ApiEndpoints.updateUser, data: {
        "username": entity.username,
        "email": entity.email,
        // ... other fields
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
        // Assuming the response data is a list of maps, where each map
        // represents an AuthEntity
        final List<dynamic> data = response.data;
        final List<AuthEntity> authEntities = data
            .map((item) => AuthEntity.fromJson(item as Map<String, dynamic>))
            .toList();
        return authEntities;
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
