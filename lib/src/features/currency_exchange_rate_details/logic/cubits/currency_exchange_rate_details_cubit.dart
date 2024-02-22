import 'package:bloc/bloc.dart';
import 'package:exchange_rates/src/features/currency_exchange_rate_details/data/models/currency_exchange_rates_chart_data.dart';
import 'package:exchange_rates/src/features/currency_exchange_rate_details/data/repos/currency_exchange_rate_details_repo.dart';

part 'currency_exchange_rate_details_state.dart';

class CurrencyExchangeRateDetailsCubit
    extends Cubit<CurrencyExchangeRateDetailsState> {
  CurrencyExchangeRateDetailsCubit(this.currencyExchangeRateDetailsRepo)
      : super(CurrencyExchangeRateDetailsInitial());

  final CurrencyExchangeRateDetailsRepo currencyExchangeRateDetailsRepo;

  CurrencyExchangeRatesChartData? _chartData;

  CurrencyExchangeRatesChartData get chartData => _chartData!;

  void getCurrencyExchangeRateDetails({required String currencyCode}) async {
    emit(CurrencyExchangeRateDetailsLoading());
    final result = await currencyExchangeRateDetailsRepo
        .getCurrencyExchangeRateDetails(currencyCode: currencyCode);
    result.fold(
      (failure) => emit(
          CurrencyExchangeRateDetailsFailedToLoad(failMsg: failure.failMsg)),
      (chartData) {
        _chartData = chartData;
        emit(CurrencyExchangeRateDetailsLoaded(chartData: chartData));
      },
    );
  }
}
