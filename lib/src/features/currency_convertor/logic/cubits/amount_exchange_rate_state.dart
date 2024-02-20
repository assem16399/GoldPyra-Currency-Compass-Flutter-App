part of 'amount_exchange_rate_cubit.dart';

abstract class AmountExchangeRateState {}

class AmountExchangeRateInitial extends AmountExchangeRateState {}

class AmountExchangeRateLoading extends AmountExchangeRateState {}

class AmountExchangeRateLoaded extends AmountExchangeRateState {
  final AmountExchangeRate amountExchangeRate;

  AmountExchangeRateLoaded({required this.amountExchangeRate});
}

class AmountExchangeRateFailedToLoad extends AmountExchangeRateState {
  final String message;

  AmountExchangeRateFailedToLoad({required this.message});
}
