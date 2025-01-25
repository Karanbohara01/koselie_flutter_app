// import 'package:dio/dio.dart';

// class DioErrorInterceptor extends Interceptor {
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) {
//     if (err.response != null) {
//       // Handle server errors
//       if (err.response!.statusCode! >= 300) {
//         err = DioException(
//           requestOptions: err.requestOptions,
//           response: err.response,
//           error: err.response!.data['message'] ?? err.response!.statusMessage!,
//           type: err.type,
//         );
//       } else {
//         err = DioException(
//           requestOptions: err.requestOptions,
//           response: err.response,
//           error: 'Something went wrong',
//           type: err.type,
//         );
//       }
//     } else {
//       // Handle conncetion errors
//       err = DioException(
//         requestOptions: err.requestOptions,
//         error: 'Connection error',
//         type: err.type,
//       );
//     }
//     super.onError(err, handler);
//   }
// }

import 'package:dio/dio.dart';
import 'package:koselie/app/constants/server_exception.dart';

class DioErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      // Handle server errors
      if (err.response!.statusCode! >= 300) {
        String errorMessage;
        if (err.response!.data is Map) {
          errorMessage = err.response!.data['message'] ??
              err.response!.statusMessage ??
              "Unknown Error";
        } else {
          errorMessage = err.response!.statusMessage ?? "Unknown Error";
        }
        throw ServerException(errorMessage,
            statusCode: err.response!.statusCode);
      } else {
        throw ServerException('Something went wrong',
            statusCode: err.response!.statusCode);
      }
    } else {
      // Handle conncetion errors
      throw ServerException('Connection error', statusCode: 500);
    }
  }
}
