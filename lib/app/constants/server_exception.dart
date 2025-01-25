class ServerException implements Exception {
  final String message;
  final int? statusCode;

  ServerException(this.message, {this.statusCode});

  @override
  String toString() {
    return 'ServerException: $message, Status Code: $statusCode';
  }
}
