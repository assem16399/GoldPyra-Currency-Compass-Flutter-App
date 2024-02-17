import 'package:bloc/bloc.dart';

import '../../data/models/gold_price.dart';
import '../../data/repos/gold_prices_repo.dart';

part 'gold_prices_state.dart';

class GoldPricesCubit extends Cubit<GoldPricesState> {
  GoldPricesCubit({required this.goldPricesRepo}) : super(GoldPricesInitial());
  final GoldPricesRepo goldPricesRepo;
  GoldPrices? _goldPrices;

  GoldPrices get goldPrices => _goldPrices!;

  void getGoldPrices() async {
    if (_goldPrices != null) return;
    emit(GoldPricesLoading());
    refreshGoldPrices();
  }

  void refreshGoldPrices() async {
    final either = await goldPricesRepo.getGoldPricesFromDataSource();
    either.fold(
        (failure) => emit(GoldPricesFailedToLoad(failMsg: failure.failMsg)),
        (goldPrices) {
      _goldPrices = goldPrices;
      emit(GoldPricesLoaded(goldPrices: _goldPrices!));
    });
  }
}
