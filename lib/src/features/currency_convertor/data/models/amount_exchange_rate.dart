import 'package:exchange_rates/src/features/currency/data/models/currency_exchange_rate.dart';

class AmountExchangeRate {
  final CurrencyExchangeRate currencyExchangeRate;
  final double amount;

  AmountExchangeRate(
      {required this.currencyExchangeRate, required this.amount});

  factory AmountExchangeRate.empty() {
    return AmountExchangeRate(
        currencyExchangeRate: CurrencyExchangeRate.empty(), amount: 0);
  }

  factory AmountExchangeRate.egpUSD() {
    return AmountExchangeRate(
        currencyExchangeRate: CurrencyExchangeRate.egpUSD(), amount: 1);
  }

  double get amountInBaseCurrency {
    return amount * currencyExchangeRate.exchangeRate;
  }

  String get formattedAmount {
    return amount.toStringAsFixed(2);
  }

  String get formattedAmountInBaseCurrency {
    return amountInBaseCurrency.toStringAsFixed(2);
  }

  String get formattedAmountInTargetCurrency {
    return amountInTargetCurrency.toStringAsFixed(2);
  }

  double get exchangeRateInBaseCurrency {
    return currencyExchangeRate.exchangeRate;
  }

  double get amountInTargetCurrency {
    return amount / currencyExchangeRate.exchangeRate;
  }

  AmountExchangeRate copyWith(
      {CurrencyExchangeRate? currencyExchangeRate, double? amount}) {
    return AmountExchangeRate(
      currencyExchangeRate: currencyExchangeRate ?? this.currencyExchangeRate,
      amount: amount ?? this.amount,
    );
  }

  factory AmountExchangeRate.fromJson(Map<String, dynamic> json,
      {required double amount}) {
    return AmountExchangeRate(
        currencyExchangeRate: CurrencyExchangeRate.fromJson(json),
        amount: amount);
  }
}
