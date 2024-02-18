part of 'gold_prices_cubit.dart';

abstract class GoldPricesState {}

class GoldPricesInitial extends GoldPricesState {}

class GoldPricesLoading extends GoldPricesState {}

class GoldPricesLoaded extends GoldPricesState {
  GoldPricesLoaded({required this.goldPrices});
  final GoldPrices goldPrices;
}

class GoldPricesFailedToLoad extends GoldPricesState {
  GoldPricesFailedToLoad({required this.failMsg});
  final String failMsg;
}
