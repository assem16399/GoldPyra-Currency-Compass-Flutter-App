part of 'gold_prices_cubit.dart';

abstract class GoldPricesState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoldPricesState;
  }

  @override
  int get hashCode => 0;
}

class GoldPricesInitial extends GoldPricesState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoldPricesInitial;
  }

  @override
  int get hashCode => 0;
}

class GoldPricesLoading extends GoldPricesState {
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoldPricesLoading;
  }

  @override
  int get hashCode => 0;
}

class GoldPricesLoaded extends GoldPricesState {
  final GoldPrices goldPrices;

  GoldPricesLoaded({required this.goldPrices});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoldPricesLoaded && other.goldPrices == goldPrices;
  }

  @override
  int get hashCode => goldPrices.hashCode;
}

class GoldPricesFailedToLoad extends GoldPricesState {
  final String failMsg;

  GoldPricesFailedToLoad({required this.failMsg});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GoldPricesFailedToLoad && other.failMsg == failMsg;
  }

  @override
  int get hashCode => failMsg.hashCode;
}
