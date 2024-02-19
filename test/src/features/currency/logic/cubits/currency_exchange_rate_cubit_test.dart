import 'package:dartz/dartz.dart';
import 'package:exchange_rates/src/core/errors/failures.dart';
import 'package:exchange_rates/src/features/currency/data/models/currency_exchange_rate.dart';
import 'package:exchange_rates/src/features/currency/data/repos/currency_exchange_rate_repo.dart';
import 'package:exchange_rates/src/features/currency/logic/cubit/currency_exchange_rate_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'currency_exchange_rate_cubit_test.mocks.dart';

@GenerateMocks([CurrencyExchangeRateRepo])
void main() {
  late CurrencyExchangeRateRepo mockCurrencyExchangeRateRepo;
  late CurrencyExchangeRateCubit currencyExchangeRateCubit;

  setUp(() {
    mockCurrencyExchangeRateRepo = MockCurrencyExchangeRateRepo();
    currencyExchangeRateCubit = CurrencyExchangeRateCubit(
        currencyExchangeRateRepo: mockCurrencyExchangeRateRepo);
  });

  test('initial state should be CurrencyExchangeRateInitial', () {
    expect(
        currencyExchangeRateCubit.state, const CurrencyExchangeRateInitial());
  });

  group('getCurrencyExchangeRate', () {
    final tExchangeRate = CurrencyExchangeRate(
      baseCurrencyCode: 'EGP',
      correspondingCurrencyCode: 'USD',
      exchangeRate: 0.03236656,
      date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
    );
    test(
        'should emit [CurrencyExchangeRateLoading, CurrencyExchangeRateLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockCurrencyExchangeRateRepo.getCurrencyExchangeRateFromDataSource())
          .thenAnswer((_) => Future.value(Right(tExchangeRate)));
      // assert later
      final expected = [
        const CurrencyExchangeRateLoading(),
        CurrencyExchangeRateLoaded(currencyExchangeRate: tExchangeRate)
      ];
      expectLater(currencyExchangeRateCubit.stream, emitsInOrder(expected));
      // act
      currencyExchangeRateCubit.getCurrencyExchangeRate();
    });

    test(
        'should emit [CurrencyExchangeRateLoading, CurrencyExchangeRateFailedToLoad] when getting data fails',
        () async {
      // arrange
      const tFailMsg = 'No Internet Connection';
      when(mockCurrencyExchangeRateRepo.getCurrencyExchangeRateFromDataSource())
          .thenAnswer((_) async => Left(NoInternetFailure(tFailMsg)));
      // assert later
      final expected = [
        const CurrencyExchangeRateLoading(),
        CurrencyExchangeRateFailedToLoad(failMsg: tFailMsg)
      ];
      expectLater(currencyExchangeRateCubit.stream, emitsInOrder(expected));
      // act
      currencyExchangeRateCubit.getCurrencyExchangeRate();
    });
  });

  group('refreshCurrencyExchangeRate', () {
    final tExchangeRate = CurrencyExchangeRate(
      baseCurrencyCode: 'EGP',
      correspondingCurrencyCode: 'USD',
      exchangeRate: 0.03236656,
      date: DateTime.fromMillisecondsSinceEpoch(1585267200 * 1000),
    );
    test(
        'should emit [CurrencyExchangeRateLoaded] when data is gotten successfully',
        () async {
      // arrange
      when(mockCurrencyExchangeRateRepo.getCurrencyExchangeRateFromDataSource())
          .thenAnswer((_) => Future.value(Right(tExchangeRate)));
      // assert later
      final expected = [
        CurrencyExchangeRateLoaded(currencyExchangeRate: tExchangeRate)
      ];
      expectLater(currencyExchangeRateCubit.stream, emitsInOrder(expected));
      // act
      currencyExchangeRateCubit.refreshCurrencyExchangeRate();
    });

    test(
        'should emit [CurrencyExchangeRateFailedToLoad] when getting data fails',
        () async {
      // arrange
      when(mockCurrencyExchangeRateRepo.getCurrencyExchangeRateFromDataSource())
          .thenAnswer(
              (_) async => Left(NoInternetFailure('No Internet Connection')));
      // assert later
      final expected = [
        CurrencyExchangeRateFailedToLoad(failMsg: 'No Internet Connection')
      ];
      expectLater(currencyExchangeRateCubit.stream, emitsInOrder(expected));
      // act
      currencyExchangeRateCubit.refreshCurrencyExchangeRate();
    });
  });
}
