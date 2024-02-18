class GoldPrices {
  final String baseCurrencyCode;
  final DateTime date;
  final double gold24kPrice;
  final double gold22kPrice;
  final double gold21kPrice;
  final double gold20kPrice;
  final double gold18kPrice;
  final double gold16kPrice;
  final double gold14kPrice;
  final double gold10kPrice;

  GoldPrices({
    required this.baseCurrencyCode,
    required this.date,
    required this.gold24kPrice,
    required this.gold22kPrice,
    required this.gold21kPrice,
    required this.gold20kPrice,
    required this.gold18kPrice,
    required this.gold16kPrice,
    required this.gold14kPrice,
    required this.gold10kPrice,
  });

  factory GoldPrices.fromJson(Map<String, dynamic> json) {
    return GoldPrices(
      baseCurrencyCode: json['currency'],
      date: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] * 1000),
      gold24kPrice: json['price_gram_24k'],
      gold22kPrice: json['price_gram_22k'],
      gold21kPrice: json['price_gram_21k'],
      gold20kPrice: json['price_gram_20k'],
      gold18kPrice: json['price_gram_18k'],
      gold16kPrice: json['price_gram_16k'],
      gold14kPrice: json['price_gram_14k'],
      gold10kPrice: json['price_gram_10k'],
    );
  }
}
