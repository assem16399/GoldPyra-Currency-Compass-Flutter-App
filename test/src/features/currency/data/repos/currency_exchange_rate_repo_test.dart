import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:exchange_rates/src/core/errors/exceptions.dart';
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
    final tCurrencyExchangeRateRawData =
        jsonDecode(fixture('currency_exchange_rate.json'));
    final tCurrencyExchangeRate = CurrencyExchangeRate(
      baseCurrencyCode: 'EGP',
      correspondingCurrencyCode: 'USD',
      exchangeRate: 0.03236656,
      date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
    );

    test('Should call getCurrencyExchangeRate from data source', () {
      // arrange
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData())
          .thenAnswer((_) async => tCurrencyExchangeRateRawData);
      // act
      repo.getCurrencyExchangeRateFromDataSource();
      // assert
      verify(mockCurrencyExchangeRateRemoteDataSource
          .getCurrencyExchangeRateRawData());
    });

    test(
        'should return CurrencyExchangeRate when the call to remote data source is successful',
        () async {
      // arrange
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData())
          .thenAnswer((_) async => tCurrencyExchangeRateRawData);

      // act
      final result = await repo.getCurrencyExchangeRateFromDataSource();

      // assert
      expect(result, isA<Right<Failure, CurrencyExchangeRate>>());
      expect(result, equals(Right(tCurrencyExchangeRate)));
    });

    test(
        'should return a failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockCurrencyExchangeRateRemoteDataSource
              .getCurrencyExchangeRateRawData())
          .thenThrow(NoInternetException());

      // act
      final result = await repo.getCurrencyExchangeRateFromDataSource();

      // assert
      expect(result, isA<Left<Failure, CurrencyExchangeRate>>());
      expect(result, equals(Left(NoInternetFailure())));
    });
  });
}
