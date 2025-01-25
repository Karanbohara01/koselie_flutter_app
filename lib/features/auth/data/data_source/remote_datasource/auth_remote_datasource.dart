// import 'package:dio/dio.dart';
// import 'package:koselie/app/constants/api_endpoints.dart';
// import 'package:koselie/features/auth/data/data_source/auth_data_source.dart';
// import 'package:koselie/features/auth/data/model/auth_api_model.dart';
// import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

// class AuthRemoteDatasource implements IAuthDataSource {
//   final Dio _dio;
//   AuthRemoteDatasource(this._dio);
//   @override
//   Future<AuthEntity> getCurrentUser() {
//     // TODO: implement getCurrentUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<String> loginUser(String username, String password) {
//     // TODO: implement loginUser
//     throw UnimplementedError();
//   }

//   @override
//   Future<void> registerUser(AuthEntity entity) async {
//     try {
//       // convert entity to model
//       var authApiModel = AuthApiModel.fromEntity(entity);
//       var response = await _dio.post(
//         ApiEndpoints.register,
//         data: authApiModel.toJson(),
//       );
//       if (response.statusCode == 201) {
//         return;
//       } else {
//         throw Exception(response.statusMessage);
//       }
//     } on DioException catch (e) {
//       throw Exception(e);
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
// }
import 'package:dio/dio.dart';
import 'package:koselie/app/constants/api_endpoints.dart';
import 'package:koselie/app/constants/server_exception.dart';
import 'package:koselie/features/auth/data/data_source/auth_data_source.dart';
import 'package:koselie/features/auth/data/model/auth_api_model.dart';
import 'package:koselie/features/auth/domain/entity/auth_entity.dart';

class AuthRemoteDatasource implements IAuthDataSource {
  final Dio _dio;
  AuthRemoteDatasource(this._dio);
  @override
  Future<AuthEntity> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> loginUser(String username, String password) {
    // TODO: implement loginUser
    throw UnimplementedError();
  }

  @override
  Future<void> registerUser(AuthEntity entity) async {
    try {
      // convert entity to model
      var authApiModel = AuthApiModel.fromEntity(entity);
      var response = await _dio.post(
        ApiEndpoints.register,
        data: authApiModel.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 201) {
        return;
      } else {
        throw ServerException(response.statusMessage ?? 'Unknown Error',
            statusCode: response.statusCode);
      }
    } on DioException catch (e) {
      throw ServerException('Dio Error: ${e.message}',
          statusCode: e.response?.statusCode);
    } catch (e) {
      throw ServerException('An unexpected error occurred', statusCode: 500);
    }
  }
}
