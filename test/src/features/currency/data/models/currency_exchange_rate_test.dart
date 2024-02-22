import 'dart:convert';

import 'package:exchange_rates/src/features/currency/data/models/currency_exchange_rate.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final egpUSDExchangeRate = CurrencyExchangeRate(
    baseCurrencyCode: 'EGP',
    correspondingCurrencyCode: 'USD',
    exchangeRate: 0.03236656,
    date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
  );

  final usdEGPExchangeRate = CurrencyExchangeRate(
    baseCurrencyCode: 'USD',
    correspondingCurrencyCode: 'EGP',
    exchangeRate: 30.875,
    date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
  );

  final currencyExchangeRates = CurrencyExchangeRates(
    currencyExchangeRates: [egpUSDExchangeRate, usdEGPExchangeRate],
  );

  test(
    'should return a valid CurrencyExchangeRate model corresponding to the JSON object',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('egp_usd_currency_exchange_rate.json'));
      // act
      final result = CurrencyExchangeRate.fromJson(jsonMap);
      // assert
      expect(result, egpUSDExchangeRate);
    },
  );

  test(
    'should return a valid CurrencyExchangeRates model corresponding to the JSON object',
    () async {
      // arrange
      final Map<String, dynamic> egpUSDJsonMap =
          json.decode(fixture('egp_usd_currency_exchange_rate.json'));
      final Map<String, dynamic> usdEGPJsonMap =
          json.decode(fixture('usd_egp_currency_exchange_rate.json'));
      final jsonMap = [egpUSDJsonMap, usdEGPJsonMap];
      // act
      final result = CurrencyExchangeRates.fromResponses(jsonMap);
      // assert
      expect(result, currencyExchangeRates);
    },
  );
}
