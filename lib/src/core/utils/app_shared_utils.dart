import 'dart:io';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

import '../errors/exceptions.dart';
import '../errors/failures.dart';

// Utility class for handling common operations in the application.
abstract class AppSharedUtils {
  // Method to get a custom exception based on a DioException.
  static Exception getCustomExceptionBasedOnDioException(DioException error) {
    // Check the type of DioException and return the appropriate custom exception.
    switch (error.type) {
      case DioExceptionType.connectionError:
        return NoInternetException();
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return TimeOutException();
      default:
        return ServerException();
    }
  }

  // Method to get a failure based on an exception.
  static Failure _getFailureBasedOnException(AppException exception) =>
      exception
          .failure; // Return the failure object associated with the exception.

  static Failure handleError(Object error) {
    if (error is! AppException) return CustomFailure();
    return _getFailureBasedOnException(error);
  }

  static String getCurrencySymbol({required String currencyCode}) {
    final format = NumberFormat.simpleCurrency(
        locale: Platform.localeName, name: currencyCode);
    return format.currencySymbol;
  }
}
