part of 'currency_exchange_rate_cubit.dart';

abstract class CurrencyExchangeRateState {
  const CurrencyExchangeRateState();
}

class CurrencyExchangeRateInitial extends CurrencyExchangeRateState {
  const CurrencyExchangeRateInitial();
}

class CurrencyExchangeRateLoading extends CurrencyExchangeRateState {
  const CurrencyExchangeRateLoading();
}

class CurrencyExchangeRateLoaded extends CurrencyExchangeRateState {
  CurrencyExchangeRateLoaded({required this.currencyExchangeRate});
  final CurrencyExchangeRate currencyExchangeRate;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRateLoaded &&
        other.currencyExchangeRate == currencyExchangeRate;
  }

  @override
  int get hashCode => currencyExchangeRate.hashCode;
}

class CurrencyExchangeRateFailedToLoad extends CurrencyExchangeRateState {
  CurrencyExchangeRateFailedToLoad({required this.failMsg});
  final String failMsg;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRateFailedToLoad &&
        other.failMsg == failMsg;
  }

  @override
  int get hashCode => failMsg.hashCode;
}
