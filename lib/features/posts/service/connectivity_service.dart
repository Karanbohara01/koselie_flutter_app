import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    print("Internet Check (Now): $result"); // Debug Output
    return result != ConnectivityResult.none;
  }

  Stream<ConnectivityResult> get connectivityStream {
    return _connectivity.onConnectivityChanged
        .map((List<ConnectivityResult> results) {
      final connection =
          results.isNotEmpty ? results.first : ConnectivityResult.none;
      print("Connectivity Changed: $connection"); // Debug Output
      return connection;
    });
  }
}
