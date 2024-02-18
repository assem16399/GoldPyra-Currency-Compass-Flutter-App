abstract class Failure {
  final String? error;

  Failure([this.error]);

  String get failMsg;

  @override
  String toString() => 'Failure: $failMsg';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

class NoInternetFailure extends Failure {
  NoInternetFailure([super.error]);

  @override
  String get failMsg => error ?? 'No internet connection!';
}

class TimeoutFailure extends Failure {
  TimeoutFailure([super.error]);

  @override
  String get failMsg => error ?? 'Server timeout!';
}

class ServerFailure extends Failure {
  ServerFailure([super.error]);

  @override
  String get failMsg => error ?? 'Failed to connect to the server!';
}

class CacheFailure extends Failure {
  CacheFailure([super.error]);

  @override
  String get failMsg => error ?? 'No data found in cache!';
}

class CustomFailure extends Failure {
  CustomFailure([super.error]);

  @override
  String get failMsg => error ?? 'Something went wrong!';
}
