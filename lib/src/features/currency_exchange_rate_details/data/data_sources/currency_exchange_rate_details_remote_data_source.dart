import 'package:exchange_rates/src/core/network/web_service.dart';

abstract class CurrencyExchangeRateDetailsRemoteDataSource {
  /// Method to get the exchange rate details for a given currency code and a date.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<Map<String, dynamic>> getCurrencyExchangeRateDetailRawData(
      {required String currencyCode, required String date});
}

class CurrencyExchangeRateDetailsRemoteDataSourceImpl
    implements CurrencyExchangeRateDetailsRemoteDataSource {
  final WebService webService;

  CurrencyExchangeRateDetailsRemoteDataSourceImpl({required this.webService});

  @override
  Future<Map<String, dynamic>> getCurrencyExchangeRateDetailRawData(
      {required String currencyCode, required String date}) async {
    return await webService.getRequest(path: '/history/$currencyCode/$date');
  }
}
