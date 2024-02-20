import 'package:exchange_rates/src/core/widgets/on_error_refresh_button.dart';
import 'package:exchange_rates/src/features/currency_convertor/logic/cubits/amount_exchange_rate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/currencies_and_flags.dart';
import '../widgets/currency_convertor.dart';
import '../widgets/current_currency_exchange_rate.dart';
import '../widgets/last_update_time.dart';
import '/src/core/constants/app_sizes.dart';

class CurrencyConvertorScreen extends StatefulWidget {
  const CurrencyConvertorScreen({super.key});

  static const routeName = '/currency-convertor';

  @override
  State<CurrencyConvertorScreen> createState() =>
      _CurrencyConvertorScreenState();
}

class _CurrencyConvertorScreenState extends State<CurrencyConvertorScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AmountExchangeRateCubit>().getPairExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Convertor')),
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: BlocBuilder<AmountExchangeRateCubit, AmountExchangeRateState>(
          builder: (context, state) {
            if (state is AmountExchangeRateLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is AmountExchangeRateFailedToLoad) {
              return OnErrorRefreshButton(
                  failMsg: state.message,
                  onRefreshPressed: () {
                    context
                        .read<AmountExchangeRateCubit>()
                        .getPairExchangeRate();
                  });
            }
            final amountExchangeRate =
                context.read<AmountExchangeRateCubit>().amountExchangeRate;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentCurrencyExchangeRate(
                      amountExchangeRate: amountExchangeRate),
                  gapH32,
                  LastUpdateTime(
                      lastUpdateTime:
                          amountExchangeRate.currencyExchangeRate.date),
                  gapH32,
                  CurrenciesAndFlags(
                      isEGPBaseCurrency: amountExchangeRate
                              .currencyExchangeRate.baseCurrencyCode ==
                          'EGP'),
                  gapH16,
                  CurrencyConvertor(amountExchangeRate: amountExchangeRate),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
