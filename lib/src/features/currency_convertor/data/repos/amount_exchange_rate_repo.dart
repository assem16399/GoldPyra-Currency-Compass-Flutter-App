import 'package:dartz/dartz.dart';
import 'package:exchange_rates/src/core/errors/failures.dart';
import 'package:exchange_rates/src/features/currency_convertor/data/models/amount_exchange_rate.dart';

import '../../../../core/utils/app_shared_utils.dart';
import '../data_sources/amount_exchange_rate_remote_data_source.dart';

abstract class AmountExchangeRateRepo {
  Future<Either<Failure, AmountExchangeRate>> getPairExchangeRateRawData(
      {required AmountExchangeRate amountExchangeRate});
}

class AmountExchangeRateRepoImpl implements AmountExchangeRateRepo {
  AmountExchangeRateRepoImpl(
      {required this.amountExchangeRateRemoteDataSource});

  final AmountExchangeRateRemoteDataSource amountExchangeRateRemoteDataSource;

  @override
  Future<Either<Failure, AmountExchangeRate>> getPairExchangeRateRawData(
      {required AmountExchangeRate amountExchangeRate}) async {
    try {
      final exchangeRate = amountExchangeRate.currencyExchangeRate;

      final pairExchangeRateRawData =
          await amountExchangeRateRemoteDataSource.getPairExchangeRateRawData(
              baseCurrencyCode: exchangeRate.baseCurrencyCode,
              correspondingCurrencyCode: exchangeRate.correspondingCurrencyCode,
              amount: amountExchangeRate.amount);

      return Right(AmountExchangeRate.fromJson(pairExchangeRateRawData,
          amount: amountExchangeRate.amount));
    } catch (error) {
      return left(AppSharedUtils.handleError(error));
    }
  }
}
