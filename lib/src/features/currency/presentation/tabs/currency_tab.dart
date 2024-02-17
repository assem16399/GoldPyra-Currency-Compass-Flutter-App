import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/currency_exchange_rate_cubit.dart';
import '../widgets/exchange_rates_list_item.dart';
import '/src/core/constants/app_sizes.dart';
import '/src/core/widgets/on_error_refresh_button.dart';
import '/src/core/widgets/operation_headline.dart';

class CurrencyTab extends StatefulWidget {
  const CurrencyTab({super.key});

  @override
  State<CurrencyTab> createState() => _CurrencyTabState();
}

class _CurrencyTabState extends State<CurrencyTab> {
  @override
  void initState() {
    super.initState();
    context.read<CurrencyExchangeRateCubit>().getCurrencyExchangeRate();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context
          .read<CurrencyExchangeRateCubit>()
          .refreshCurrencyExchangeRate(),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child:
            BlocBuilder<CurrencyExchangeRateCubit, CurrencyExchangeRateState>(
          builder: (context, state) {
            if (state is CurrencyExchangeRateLoading) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state is CurrencyExchangeRateFailedToLoad) {
              return OnErrorRefreshButton(
                  failMsg: state.failMsg,
                  onRefreshPressed: context
                      .read<CurrencyExchangeRateCubit>()
                      .getCurrencyExchangeRate);
            }
            final exchangeRate =
                context.read<CurrencyExchangeRateCubit>().currencyExchangeRate;
            return Column(
              children: [
                OperationHeadLine(
                    operation: 'Exchange Rates', date: exchangeRate.date),
                gapH16,
                Expanded(
                  child: ListView(
                    children: [
                      ExchangeRatesListItem(
                        baseCurrencyCode: exchangeRate.baseCurrencyCode,
                        correspondingCurrencyCode:
                            exchangeRate.correspondingCurrencyCode,
                        rate: exchangeRate.exchangeRate,
                        baseCountryCode: 'EG',
                        correspondingCountryCode: 'US',
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
