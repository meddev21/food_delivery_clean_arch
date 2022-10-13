class OfflineException implements Exception {}

class EmptyCacheException implements Exception {}

class FetchDataException implements Exception {}

class InvalidInputException implements Exception {}

class AuthenticationException implements Exception {}

class BadRequestException implements Exception {}

class UnauthorisedException implements Exception {}

class TimeOutException implements Exception {}

class RequestException implements Exception {
  final int? statusCode;
  final String? statusText;
  final String? details;

  const RequestException({
    required this.statusCode,
    required this.statusText,
    required this.details,
  });
}
