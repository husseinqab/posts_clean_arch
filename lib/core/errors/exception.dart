class ServerException implements Exception {}
class UnAuthorizedException implements Exception {}
class NotFoundException implements Exception {}
class UnExpectedException implements Exception {}
class DWApiException implements Exception {
  String message;
  DWApiException({required this.message});
}