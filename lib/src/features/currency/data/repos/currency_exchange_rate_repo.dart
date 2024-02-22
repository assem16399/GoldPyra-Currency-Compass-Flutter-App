import 'package:dartz/dartz.dart';

import '../data_sources/currency_exchange_rate_remote_data_source.dart';
import '/src/core/errors/failures.dart';
import '/src/core/utils/app_shared_utils.dart';
import '/src/features/currency/data/models/currency_exchange_rate.dart';

abstract class CurrencyExchangeRateRepo {
  Future<Either<Failure, CurrencyExchangeRates>>
      getCurrencyExchangeRatesFromDataSource();
}

class CurrencyExchangeRateRepoImpl implements CurrencyExchangeRateRepo {
  CurrencyExchangeRateRepoImpl(this.currencyExchangeRateDataSource);

  final CurrencyExchangeRateRemoteDataSource currencyExchangeRateDataSource;

  @override
  Future<Either<Failure, CurrencyExchangeRates>>
      getCurrencyExchangeRatesFromDataSource() async {
    try {
      final responses = await _sendTwoRequestsConcurrently();
      return _handleExchangeRatesResponses(responses);
    } catch (error) {
      return left(AppSharedUtils.handleError(error));
    }
  }

  Future<List<Map<String, dynamic>>> _sendTwoRequestsConcurrently() async {
    final responses = await Future.wait([
      currencyExchangeRateDataSource.getCurrencyExchangeRateRawData(
          baseCurrency: 'EGP', targetCurrency: 'USD'),
      currencyExchangeRateDataSource.getCurrencyExchangeRateRawData(
          baseCurrency: 'USD', targetCurrency: 'EGP'),
    ]);
    return responses;
  }

  Either<Failure, CurrencyExchangeRates> _handleExchangeRatesResponses(
      List<Map<String, dynamic>> responses) {
    for (var response in responses) {
      if (response['result'] == 'error') return left(ServerFailure());
    }

    return right(CurrencyExchangeRates.fromResponses(responses));
  }
}
