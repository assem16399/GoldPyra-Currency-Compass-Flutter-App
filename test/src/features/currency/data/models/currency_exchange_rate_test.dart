import 'dart:convert';

import 'package:exchange_rates/src/features/currency/data/models/currency_exchange_rate.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final exchangeRate = CurrencyExchangeRate(
    baseCurrencyCode: 'EGP',
    correspondingCurrencyCode: 'USD',
    exchangeRate: 0.03236656,
    date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
  );

  test(
    'should return a valid model corresponding to the JSON object',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('currency_exchange_rate.json'));
      // act
      final result = CurrencyExchangeRate.fromJson(jsonMap);
      // assert
      expect(result.runtimeType, exchangeRate.runtimeType);
    },
  );
}
