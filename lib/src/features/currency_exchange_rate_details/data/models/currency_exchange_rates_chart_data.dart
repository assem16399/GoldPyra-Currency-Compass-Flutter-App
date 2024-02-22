import 'package:intl/intl.dart';

import '../../../currency/data/models/currency_exchange_rate.dart';

class CurrencyExchangeRatesChartData {
  CurrencyExchangeRatesChartData({required this.currencyExchangeRates});

  factory CurrencyExchangeRatesChartData.fromResponses(
      List<Map<String, dynamic>> response) {
    final List<CurrencyExchangeRate> currencyExchangeRates = response
        .map((currencyExchangeRate) =>
            CurrencyExchangeRate.fromHistoricalRequestJson(
                currencyExchangeRate))
        .toList();
    return CurrencyExchangeRatesChartData(
        currencyExchangeRates: currencyExchangeRates);
  }

  final List<CurrencyExchangeRate> currencyExchangeRates;

  double get maxExchangeRate => currencyExchangeRates
      .map((currencyExchangeRate) => currencyExchangeRate.exchangeRate)
      .reduce((value, element) => value > element ? value : element);

  double get minExchangeRate => currencyExchangeRates
      .map((currencyExchangeRate) => currencyExchangeRate.exchangeRate)
      .reduce((value, element) => value < element ? value : element);

  double get averageExchangeRate =>
      currencyExchangeRates
          .map((currencyExchangeRate) => currencyExchangeRate.exchangeRate)
          .reduce((value, element) => value + element) /
      currencyExchangeRates.length;

  List<Map> get normalizedValues {
    final List<Map> normalizedValues = [];
    for (var i = 0; i < currencyExchangeRates.length; i++) {
      normalizedValues.add({
        'x': i,
        'y': currencyExchangeRates[i].exchangeRate,
        i: DateFormat.MMM().format(currencyExchangeRates[i].date),
      });
    }
    return normalizedValues;
  }
}
