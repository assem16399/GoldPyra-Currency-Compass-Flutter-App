import '/src/core/constants/api_keys.dart';
import '/src/core/constants/base_urls.dart';
import '/src/core/network/web_service.dart';
import '/src/dependency_injection/injection_container.dart' as main_sl;
import 'data/data_sources/amount_exchange_rate_remote_data_source.dart';
import 'data/repos/amount_exchange_rate_repo.dart';
import 'logic/cubits/amount_exchange_rate_cubit.dart';

void init() {
  main_sl.sl.registerFactory(
      () => AmountExchangeRateCubit(amountExchangeRateRepo: main_sl.sl()));

  /// Register Repos
  main_sl.sl.registerLazySingleton<AmountExchangeRateRepo>(() =>
      AmountExchangeRateRepoImpl(
          amountExchangeRateRemoteDataSource: main_sl.sl()));

  /// Register Data Sources
  final webService = WebServiceWithDioImpl(
      baseUrl: '$kCurrenciesExchangeRateBaseUrl$kCurrenciesApiKey');

  main_sl.sl.registerLazySingleton<AmountExchangeRateRemoteDataSource>(
      () => AmountExchangeRateRemoteDataSourceImpl(webService: webService));
}
