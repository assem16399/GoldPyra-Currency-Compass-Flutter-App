import 'package:dartz/dartz.dart';

import '../data_sources/currency_exchange_rate_data_source.dart';
import '/src/core/errors/exceptions.dart';
import '/src/core/errors/failures.dart';
import '/src/core/utils/app_shared_utils.dart';
import '/src/features/currency/data/models/currency_exchange_rate.dart';

abstract class CurrencyExchangeRateRepo {
  Future<Either<Failure, CurrencyExchangeRate>>
      getCurrencyExchangeRateFromDataSource();
}

class CurrencyExchangeRateRepoImpl implements CurrencyExchangeRateRepo {
  CurrencyExchangeRateRepoImpl(this.currencyExchangeRateDataSource);

  final CurrencyExchangeRateRemoteDataSource currencyExchangeRateDataSource;

  @override
  Future<Either<Failure, CurrencyExchangeRate>>
      getCurrencyExchangeRateFromDataSource() async {
    try {
      final response =
          await currencyExchangeRateDataSource.getCurrencyExchangeRateRawData();
      return right(CurrencyExchangeRate.fromJson(response));
    } catch (error) {
      return _handleError(error);
    }
  }

  Either<Failure, CurrencyExchangeRate> _handleError(Object error) {
    if (error is! AppException) return left(CustomFailure());
    return left(AppSharedUtils.getFailureBasedOnException(error));
  }
}
