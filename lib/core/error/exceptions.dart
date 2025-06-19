class ServerException implements Exception {
  final String message;

  ServerException(this.message);
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'Cache error occurred']);
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'Network error occurred']);
}

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class NotFoundFailureException implements Exception {
  final String message;

  NotFoundFailureException([this.message = 'Resource not found']);
}
