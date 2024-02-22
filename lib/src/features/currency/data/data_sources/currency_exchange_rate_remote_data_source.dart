import 'package:exchange_rates/src/core/constants/end_points.dart';

import '/src/core/network/web_service.dart';

abstract class CurrencyExchangeRateRemoteDataSource {
  Future<Map<String, dynamic>> getCurrencyExchangeRateRawData(
      {required String baseCurrency, required String targetCurrency});
}

class CurrencyExchangeRateRemoteDataSourceImpl
    implements CurrencyExchangeRateRemoteDataSource {
  CurrencyExchangeRateRemoteDataSourceImpl({required this.webService});

  final WebService webService;

  @override
  Future<Map<String, dynamic>> getCurrencyExchangeRateRawData(
      {required String baseCurrency, required String targetCurrency}) async {
    return await webService.getRequest(
        path: '$kPairExchangeRateEndpoint/$baseCurrency/$targetCurrency');
  }
}
