part of 'currency_exchange_rate_cubit.dart';

abstract class CurrencyExchangeRateState {}

class CurrencyExchangeRateInitial extends CurrencyExchangeRateState {}

class CurrencyExchangeRateLoading extends CurrencyExchangeRateState {}

class CurrencyExchangeRateLoaded extends CurrencyExchangeRateState {
  final CurrencyExchangeRate currencyExchangeRate;

  CurrencyExchangeRateLoaded({required this.currencyExchangeRate});
}

class CurrencyExchangeRateFailedToLoad extends CurrencyExchangeRateState {
  final String failMsg;

  CurrencyExchangeRateFailedToLoad({required this.failMsg});
}
