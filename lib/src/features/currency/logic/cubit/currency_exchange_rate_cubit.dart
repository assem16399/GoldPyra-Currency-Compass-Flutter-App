import 'package:bloc/bloc.dart';

import '../../data/models/currency_exchange_rate.dart';
import '../../data/repos/currency_exchange_rate_repo.dart';

part 'currency_exchange_rate_state.dart';

class CurrencyExchangeRateCubit extends Cubit<CurrencyExchangeRateState> {
  CurrencyExchangeRateCubit({required this.currencyExchangeRateRepo})
      : super(const CurrencyExchangeRateInitial());
  final CurrencyExchangeRateRepo currencyExchangeRateRepo;
  CurrencyExchangeRate? _currencyExchangeRate;

  CurrencyExchangeRate get currencyExchangeRate => _currencyExchangeRate!;

  void getCurrencyExchangeRate() async {
    if (_currencyExchangeRate != null) return;
    emit(const CurrencyExchangeRateLoading());
    refreshCurrencyExchangeRate();
  }

  Future<void> refreshCurrencyExchangeRate() async {
    final either =
        await currencyExchangeRateRepo.getCurrencyExchangeRateFromDataSource();
    either.fold(
        (failure) =>
            emit(CurrencyExchangeRateFailedToLoad(failMsg: failure.failMsg)),
        (currencyExchangeRate) {
      _currencyExchangeRate = currencyExchangeRate;
      emit(CurrencyExchangeRateLoaded(
          currencyExchangeRate: _currencyExchangeRate!));
    });
  }
}
