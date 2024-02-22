import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:exchange_rates/src/core/errors/failures.dart';
import 'package:exchange_rates/src/features/currency/data/data_sources/currency_exchange_rate_remote_data_source.dart';
import 'package:exchange_rates/src/features/currency/data/models/currency_exchange_rate.dart';
import 'package:exchange_rates/src/features/currency/data/repos/currency_exchange_rate_repo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'currency_exchange_rate_repo_test.mocks.dart';

@GenerateMocks([CurrencyExchangeRateRemoteDataSource])
void main() {
  late CurrencyExchangeRateRemoteDataSource
      mockCurrencyExchangeRateRemoteDataSource;
  late CurrencyExchangeRateRepoImpl repo;

  setUp(() {
    mockCurrencyExchangeRateRemoteDataSource =
        MockCurrencyExchangeRateRemoteDataSource();
    repo =
        CurrencyExchangeRateRepoImpl(mockCurrencyExchangeRateRemoteDataSource);
  });

  group('getCurrencyExchangeRateFromDataSource', () {
    final tEGPUSDCurrencyExchangeRateRawData =
        jsonDecode(fixture('egp_usd_currency_exchange_rate.json'));

    final tUSDEGPCurrencyExchangeRateRawData =
        jsonDecode(fixture('usd_egp_currency_exchange_rate.json'));

    final tEgpUsdCurrencyExchangeRate = CurrencyExchangeRate(
      baseCurrencyCode: 'EGP',
      correspondingCurrencyCode: 'USD',
      exchangeRate: 0.03236656,
      date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
    );

    final tUsdEgpExchangeRate = CurrencyExchangeRate(
      baseCurrencyCode: 'USD',
      correspondingCurrencyCode: 'EGP',
      exchangeRate: 30.875,
      date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
    );

    final tCurrencyExchangeRates = CurrencyExchangeRates(
      currencyExchangeRates: [tEgpUsdCurrencyExchangeRate, tUsdEgpExchangeRate],
    );

    const tEGPCurrency = 'EGP';
    const tUSDCurrency = 'USD';

    test('Should call getCurrencyExchangeRate from data source', () async {
      // arrange
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData(
                  baseCurrency: tEGPCurrency, targetCurrency: tUSDCurrency))
          .thenAnswer((_) async => tEGPUSDCurrencyExchangeRateRawData);

      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData(
                  baseCurrency: tUSDCurrency, targetCurrency: tEGPCurrency))
          .thenAnswer((_) async => tUSDEGPCurrencyExchangeRateRawData);

      // act
      final result = await repo.getCurrencyExchangeRatesFromDataSource();
      // assert

      verifyInOrder([
        mockCurrencyExchangeRateRemoteDataSource.getCurrencyExchangeRateRawData(
            baseCurrency: tEGPCurrency, targetCurrency: tUSDCurrency),
        mockCurrencyExchangeRateRemoteDataSource.getCurrencyExchangeRateRawData(
            baseCurrency: tUSDCurrency, targetCurrency: tEGPCurrency)
      ]);

      expect(result.isRight(), true);
      expect(result.getOrElse(() => throw Exception()),
          equals(tCurrencyExchangeRates));
    });

    test(
        'should return a failure when the call to remote data source returns response with error',
        () async {
      //arrange
      // Prepare error response data
      final errorResponseData = [
        {'result': 'error'},
        {'result': 'success', 'exchange_rate': 0.5}
      ];

      // Stub the method calls
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData(
                  baseCurrency: tEGPCurrency, targetCurrency: tUSDCurrency))
          .thenAnswer((_) async => errorResponseData[0]);
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData(
                  baseCurrency: tUSDCurrency, targetCurrency: tEGPCurrency))
          .thenAnswer((_) async => errorResponseData[1]);

      //act
      // Call the method
      final result = await repo.getCurrencyExchangeRatesFromDataSource();

      //assert
      // Verify the method calls
      verify(mockCurrencyExchangeRateRemoteDataSource
          .getCurrencyExchangeRateRawData(
              baseCurrency: tEGPCurrency, targetCurrency: tUSDCurrency));
      verify(mockCurrencyExchangeRateRemoteDataSource
          .getCurrencyExchangeRateRawData(
              baseCurrency: tUSDCurrency, targetCurrency: tEGPCurrency));

      // Check the result
      expect(result.isLeft(), true);
      expect(result, equals(left(ServerFailure())));
    });

    test(
        'should return a failure when the call to remote data source is unsuccessful',
        () async {
      //arrange
      // Stub the method calls to throw an exception
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData(
                  baseCurrency: tEGPCurrency, targetCurrency: tUSDCurrency))
          .thenThrow(Exception('Test Exception'));

      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData(
                  baseCurrency: tUSDCurrency, targetCurrency: tEGPCurrency))
          .thenAnswer((_) async => tUSDEGPCurrencyExchangeRateRawData);

      //act
      // Call the method
      final result = await repo.getCurrencyExchangeRatesFromDataSource();

      //assert
      // Verify the method calls
      verify(mockCurrencyExchangeRateRemoteDataSource
          .getCurrencyExchangeRateRawData(
              baseCurrency: tEGPCurrency, targetCurrency: tUSDCurrency));

      verifyNever(mockCurrencyExchangeRateRemoteDataSource
          .getCurrencyExchangeRateRawData(
              baseCurrency: tUSDCurrency, targetCurrency: tEGPCurrency));

      // Check the result
      expect(result.isLeft(), true);
      expect(result, equals(left(CustomFailure())));
    });
  });
}
