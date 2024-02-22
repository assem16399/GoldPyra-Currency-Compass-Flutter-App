part of 'currency_exchange_rate_details_cubit.dart';

abstract class CurrencyExchangeRateDetailsState {}

class CurrencyExchangeRateDetailsInitial
    extends CurrencyExchangeRateDetailsState {}

class CurrencyExchangeRateDetailsLoading
    extends CurrencyExchangeRateDetailsState {}

class CurrencyExchangeRateDetailsLoaded
    extends CurrencyExchangeRateDetailsState {
  CurrencyExchangeRateDetailsLoaded({required this.chartData});

  final CurrencyExchangeRatesChartData chartData;
}

class CurrencyExchangeRateDetailsFailedToLoad
    extends CurrencyExchangeRateDetailsState {
  CurrencyExchangeRateDetailsFailedToLoad({required this.failMsg});

  final String failMsg;
}
