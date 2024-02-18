import 'package:dartz/dartz.dart';

import '../data_sources/gold_prices_remote_data_source.dart';
import '../models/gold_price.dart';
import '/src/core/errors/exceptions.dart';
import '/src/core/errors/failures.dart';
import '/src/core/utils/app_shared_utils.dart';

abstract class GoldPricesRepo {
  Future<Either<Failure, GoldPrices>> getGoldPricesFromDataSource();
}

class GoldPricesRepoImpl implements GoldPricesRepo {
  GoldPricesRepoImpl(this.currencyExchangeRateDataSource);

  final GoldPricesRemoteDataSource currencyExchangeRateDataSource;

  @override
  Future<Either<Failure, GoldPrices>> getGoldPricesFromDataSource() async {
    try {
      final response =
          await currencyExchangeRateDataSource.getGoldPricesRawData();
      return right(GoldPrices.fromJson(response));
    } catch (error) {
      return _handleError(error);
    }
  }

  Either<Failure, GoldPrices> _handleError(Object error) {
    if (error is! AppException) return left(CustomFailure());
    return left(AppSharedUtils.getFailureBasedOnException(error));
  }
}
