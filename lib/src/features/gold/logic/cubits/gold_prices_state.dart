part of 'gold_prices_cubit.dart';

abstract class GoldPricesState {}

class GoldPricesInitial extends GoldPricesState {}

class GoldPricesLoading extends GoldPricesState {}

class GoldPricesLoaded extends GoldPricesState {
  final GoldPrices goldPrices;

  GoldPricesLoaded({required this.goldPrices});
}

class GoldPricesFailedToLoad extends GoldPricesState {
  final String failMsg;

  GoldPricesFailedToLoad({required this.failMsg});
}
