import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    var result = await connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}

class ApiService {
  final Dio dio = Dio();
  final NetworkInfo networkInfo;

  ApiService(this.networkInfo);

  Future<List<dynamic>> fetchPosts() async {
    if (!await networkInfo.isConnected) {
      print('No internet connection');
      return [];
    }

    try {
      final response = await dio.get('http://10.0.2.2:8000/api/v1/post/all');
      return response.data;
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      return [];
    } catch (e) {
      print('Unexpected error: $e');
      return [];
    }
  }
}

void main() async {
  final networkInfo = NetworkInfoImpl(Connectivity());
  final apiService = ApiService(networkInfo);

  final posts = await apiService.fetchPosts();
  print('Posts: $posts');
}
