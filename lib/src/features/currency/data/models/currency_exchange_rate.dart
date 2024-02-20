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
