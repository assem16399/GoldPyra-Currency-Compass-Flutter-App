part of 'currency_exchange_rate_cubit.dart';

abstract class CurrencyExchangeRateState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRateState;
  }

  @override
  int get hashCode => 0;
}

class CurrencyExchangeRateInitial extends CurrencyExchangeRateState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRateInitial;
  }

  @override
  int get hashCode => 0;
}

class CurrencyExchangeRateLoading extends CurrencyExchangeRateState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRateLoading;
  }

  @override
  int get hashCode => 0;
}

class CurrencyExchangeRateLoaded extends CurrencyExchangeRateState {
  final CurrencyExchangeRate currencyExchangeRate;

  CurrencyExchangeRateLoaded({required this.currencyExchangeRate});

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
  final String failMsg;

  CurrencyExchangeRateFailedToLoad({required this.failMsg});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRateFailedToLoad &&
        other.failMsg == failMsg;
  }

  @override
  int get hashCode => failMsg.hashCode;
}
