import '/src/core/errors/failures.dart';

abstract class AppException implements Exception {
  Failure get failure;
}

class NoInternetException implements AppException {
  @override
  Failure get failure => NoInternetFailure();
}

class ServerException implements AppException {
  @override
  Failure get failure => ServerFailure();
}

class TimeOutException implements AppException {
  @override
  Failure get failure => TimeoutFailure();
}

class CacheException implements AppException {
  @override
  Failure get failure => CacheFailure();
}

class CustomException implements AppException {
  @override
  Failure get failure => CustomFailure();
}
