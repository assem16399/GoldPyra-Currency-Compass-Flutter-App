import 'package:flutter/foundation.dart';

class CurrencyExchangeRate {
  final String baseCurrencyCode;
  final String correspondingCurrencyCode;
  final double exchangeRate;
  final DateTime date;

  CurrencyExchangeRate({
    required this.baseCurrencyCode,
    required this.correspondingCurrencyCode,
    required this.exchangeRate,
    required this.date,
  });

  factory CurrencyExchangeRate.empty() {
    return CurrencyExchangeRate(
      baseCurrencyCode: '',
      correspondingCurrencyCode: '',
      exchangeRate: 0,
      date: DateTime.now(),
    );
  }

  factory CurrencyExchangeRate.egpUSD() {
    return CurrencyExchangeRate(
      baseCurrencyCode: 'EGP',
      correspondingCurrencyCode: 'USD',
      exchangeRate: 0,
      date: DateTime.now(),
    );
  }

  factory CurrencyExchangeRate.fromJson(Map<String, dynamic> json) {
    return CurrencyExchangeRate(
      baseCurrencyCode: json['base_code'],
      correspondingCurrencyCode: json['target_code'],
      exchangeRate: json['conversion_rate'],
      date: DateTime.fromMillisecondsSinceEpoch(
          json['time_last_update_unix'] * 1000),
    );
  }

  factory CurrencyExchangeRate.fromHistoricalRequestJson(
      Map<String, dynamic> json) {
    final baseCurrencyCode = json['base_code'];
    final targetCurrencyCode = baseCurrencyCode == 'EGP' ? 'USD' : 'EGP';
    final rates = json['conversion_rates'] as Map<String, dynamic>;
    return CurrencyExchangeRate(
      baseCurrencyCode: baseCurrencyCode,
      correspondingCurrencyCode: targetCurrencyCode,
      exchangeRate: rates[targetCurrencyCode],
      date: DateTime(json['year'], json['month'], json['day']),
    );
  }

  CurrencyExchangeRate copyWith({
    String? baseCurrencyCode,
    String? correspondingCurrencyCode,
  }) {
    return CurrencyExchangeRate(
      baseCurrencyCode: baseCurrencyCode ?? this.baseCurrencyCode,
      correspondingCurrencyCode:
          correspondingCurrencyCode ?? this.correspondingCurrencyCode,
      exchangeRate: exchangeRate,
      date: date,
    );
  }

  String get baseCountryCode {
    return baseCurrencyCode == 'EGP' ? 'EG' : 'US';
  }

  String get correspondingCountryCode {
    return correspondingCurrencyCode == 'USD' ? 'US' : 'EG';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRate &&
        other.baseCurrencyCode == baseCurrencyCode &&
        other.correspondingCurrencyCode == correspondingCurrencyCode &&
        other.exchangeRate == exchangeRate &&
        other.date == date;
  }

  @override
  int get hashCode {
    return baseCurrencyCode.hashCode ^
        correspondingCurrencyCode.hashCode ^
        exchangeRate.hashCode ^
        date.hashCode;
  }
}

class CurrencyExchangeRates {
  final List<CurrencyExchangeRate> currencyExchangeRates;

  CurrencyExchangeRates({required this.currencyExchangeRates});

  factory CurrencyExchangeRates.empty() {
    return CurrencyExchangeRates(currencyExchangeRates: []);
  }

  factory CurrencyExchangeRates.fromResponses(
      List<Map<String, dynamic>> responses) {
    final exchangeRates =
        responses.map((e) => CurrencyExchangeRate.fromJson(e)).toList();
    return CurrencyExchangeRates(currencyExchangeRates: exchangeRates);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CurrencyExchangeRates &&
        listEquals(other.currencyExchangeRates, currencyExchangeRates);
  }

  @override
  int get hashCode => currencyExchangeRates.hashCode;
}
