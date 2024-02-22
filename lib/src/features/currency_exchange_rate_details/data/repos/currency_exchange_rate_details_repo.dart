import 'package:dartz/dartz.dart';
import 'package:exchange_rates/src/core/errors/failures.dart';
import 'package:exchange_rates/src/core/utils/app_shared_utils.dart';
import 'package:exchange_rates/src/features/currency_exchange_rate_details/data/models/currency_exchange_rates_chart_data.dart';

import '../data_sources/currency_exchange_rate_details_remote_data_source.dart';

abstract class CurrencyExchangeRateDetailsRepo {
  /// Method to get the exchange rate details for a given currency code and a date.

  Future<Either<Failure, CurrencyExchangeRatesChartData>>
      getCurrencyExchangeRateDetails({required String currencyCode});
}

class CurrencyExchangeRateDetailsRepoImpl
    implements CurrencyExchangeRateDetailsRepo {
  final CurrencyExchangeRateDetailsRemoteDataSource remoteDataSource;

  CurrencyExchangeRateDetailsRepoImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CurrencyExchangeRatesChartData>>
      getCurrencyExchangeRateDetails({required String currencyCode}) async {
    try {
      final requests = List.generate(5, (index) {
        return remoteDataSource.getCurrencyExchangeRateDetailRawData(
            currencyCode: currencyCode,
            date:
                '${DateTime.now().subtract(Duration(days: 30 * (5 - index))).year}'
                '/${DateTime.now().subtract(Duration(days: 30 * (5 - index))).month}'
                '/${DateTime.now().subtract(Duration(days: 30 * (5 - index))).day}');
      });
      final response = await Future.wait(requests);

      final currencyExchangeRatesChartData =
          CurrencyExchangeRatesChartData.fromResponses(response);
      return Right(currencyExchangeRatesChartData);
    } catch (error) {
      return left(AppSharedUtils.handleError(error));
    }
  }
}
