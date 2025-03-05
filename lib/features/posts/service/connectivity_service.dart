import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  // Check internet connection with an additional real-world check
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    print("🌍 Internet Check (Now): $result");

    if (result == ConnectivityResult.none) {
      return false;
    }

    // 🔥 Extra step: Try a real-world internet check (Google DNS)
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print("✅ Internet is actually available");
        return true;
      }
    } catch (e) {
      print("🚫 No real internet access detected");
      return false;
    }

    return false;
  }

  // Stream to listen for connectivity changes
  Stream<ConnectivityResult> get connectivityStream {
    return _connectivity.onConnectivityChanged.map((ConnectivityResult result) {
      print("🌍 Connectivity Changed: $result");
      return result;
    } as ConnectivityResult Function(List<ConnectivityResult> event));
  }
}
