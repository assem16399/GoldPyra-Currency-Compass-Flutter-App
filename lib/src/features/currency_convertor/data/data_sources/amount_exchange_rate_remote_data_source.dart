import '/src/core/constants/end_points.dart';
import '/src/core/network/web_service.dart';

abstract class AmountExchangeRateRemoteDataSource {
  Future<Map<String, dynamic>> getPairExchangeRateRawData(
      {required String baseCurrencyCode,
      required String correspondingCurrencyCode,
      required double amount});
}

class AmountExchangeRateRemoteDataSourceImpl
    implements AmountExchangeRateRemoteDataSource {
  AmountExchangeRateRemoteDataSourceImpl({required this.webService});

  final WebService webService;

  @override
  Future<Map<String, dynamic>> getPairExchangeRateRawData(
      {required String baseCurrencyCode,
      required String correspondingCurrencyCode,
      required double amount}) async {
    return await webService.getRequest(
        path:
            '$kPairExchangeRateEndpoint/$baseCurrencyCode/$correspondingCurrencyCode/$amount');
  }
}
