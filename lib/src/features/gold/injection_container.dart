import '/src/core/constants/api_keys.dart';
import '/src/core/constants/base_urls.dart';
import '/src/core/network/web_service.dart';
import '/src/dependency_injection/injection_container.dart' as main_sl;
import 'data/data_sources/gold_prices_remote_data_source.dart';
import 'data/repos/gold_prices_repo.dart';
import 'logic/cubits/gold_prices_cubit.dart';

void init() {
  main_sl.sl
      .registerFactory(() => GoldPricesCubit(goldPricesRepo: main_sl.sl()));

  /// Register Repos
  main_sl.sl.registerLazySingleton<GoldPricesRepo>(
      () => GoldPricesRepoImpl(main_sl.sl()));

  /// Register Data Sources
  final webService = WebServiceWithDioImpl(
      baseUrl: kGoldPricesBaseUrl,
      headers: {'x-access-token': kGoldPricesApiKey});

  main_sl.sl.registerLazySingleton<GoldPricesRemoteDataSource>(
    () => GoldPricesRemoteDataSourceImpl(webService: webService),
  );
}
