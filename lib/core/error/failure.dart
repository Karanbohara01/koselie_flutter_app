class Failure {
  final String message;
  final int? statusCode;

  Failure({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() => 'Failure (message: $message, statusCode: $statusCode)';
}

/// ✅ Handles **No Internet Connection / Network Issues**
class NetworkFailure extends Failure {
  NetworkFailure({required super.message});
}

/// ✅ Handles **Local Database Errors**
class LocalDatabaseFailure extends Failure {
  LocalDatabaseFailure({required super.message});
}

/// ✅ Handles **API Request Failures**
class ApiFailure extends Failure {
  ApiFailure({required super.message, super.statusCode});
}

/// ✅ Handles **Shared Preferences Errors**
class SharedPrefsFailure extends Failure {
  SharedPrefsFailure({required super.message});
}

/// ✅ Handles **Cache Failures**
class CacheFailure extends Failure {
  CacheFailure({required super.message});
}

/// ✅ Handles **File Handling Failures**
class FileFailure extends Failure {
  FileFailure(String message) : super(message: message);
}

/// ✅ Handles **Server Failures**
class ServerFailure extends Failure {
  ServerFailure(String message, {super.statusCode}) : super(message: message);
}

/// ✅ Handles **Authentication Failures (e.g., Invalid Token, Expired Session)**
class AuthFailure extends Failure {
  AuthFailure(String message, {super.statusCode}) : super(message: message);
}
