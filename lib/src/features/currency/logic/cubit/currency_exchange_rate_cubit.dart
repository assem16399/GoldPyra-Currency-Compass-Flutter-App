import 'package:bloc/bloc.dart';

import '../../data/models/currency_exchange_rate.dart';
import '../../data/repos/currency_exchange_rate_repo.dart';

part 'currency_exchange_rate_state.dart';

class CurrencyExchangeRateCubit extends Cubit<CurrencyExchangeRateState> {
  CurrencyExchangeRateCubit({required this.currencyExchangeRateRepo})
      : super(const CurrencyExchangeRateInitial());
  final CurrencyExchangeRateRepo currencyExchangeRateRepo;
  CurrencyExchangeRates _currencyExchangeRates = CurrencyExchangeRates.empty();

  CurrencyExchangeRates get currencyExchangeRates => _currencyExchangeRates;

  void getCurrencyExchangeRate() async {
    if (_currencyExchangeRates.currencyExchangeRates.isNotEmpty) return;
    emit(const CurrencyExchangeRateLoading());
    refreshCurrencyExchangeRate();
  }

  Future<void> refreshCurrencyExchangeRate() async {
    final either =
        await currencyExchangeRateRepo.getCurrencyExchangeRatesFromDataSource();
    either.fold(
        (failure) =>
            emit(CurrencyExchangeRateFailedToLoad(failMsg: failure.failMsg)),
        (currencyExchangeRates) {
      _currencyExchangeRates = currencyExchangeRates;
      emit(CurrencyExchangeRateLoaded(
          currencyExchangeRates: _currencyExchangeRates));
    });
  }
}
