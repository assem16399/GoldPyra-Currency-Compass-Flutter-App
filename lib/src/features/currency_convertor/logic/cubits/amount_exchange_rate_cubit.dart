import 'package:bloc/bloc.dart';
import 'package:exchange_rates/src/features/currency_convertor/data/repos/amount_exchange_rate_repo.dart';

import '../../data/models/amount_exchange_rate.dart';

part 'amount_exchange_rate_state.dart';

class AmountExchangeRateCubit extends Cubit<AmountExchangeRateState> {
  AmountExchangeRateCubit({required this.amountExchangeRateRepo})
      : super(AmountExchangeRateInitial());

  final AmountExchangeRateRepo amountExchangeRateRepo;
  var _amountExchangeRate = AmountExchangeRate.egpUSD();

  AmountExchangeRate get amountExchangeRate => _amountExchangeRate;

  void getPairExchangeRate() async {
    emit(AmountExchangeRateLoading());
    final result = await amountExchangeRateRepo.getPairExchangeRateRawData(
        amountExchangeRate: _amountExchangeRate);
    result.fold(
      (failure) =>
          emit(AmountExchangeRateFailedToLoad(message: failure.failMsg)),
      (amountExchangeRate) {
        _amountExchangeRate = amountExchangeRate;
        emit(AmountExchangeRateLoaded(amountExchangeRate: _amountExchangeRate));
      },
    );
  }

  void updateAmountExchangeRateOnline(AmountExchangeRate amountExchangeRate) {
    _amountExchangeRate = amountExchangeRate;
    getPairExchangeRate();
  }

  void updateAmountExchangeRate(AmountExchangeRate amountExchangeRate) {
    _amountExchangeRate = amountExchangeRate;
  }
}
