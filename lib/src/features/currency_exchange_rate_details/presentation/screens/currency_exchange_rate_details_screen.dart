import 'package:exchange_rates/src/core/constants/app_sizes.dart';
import 'package:exchange_rates/src/core/utils/app_shared_utils.dart';
import 'package:exchange_rates/src/core/widgets/on_error_refresh_button.dart';
import 'package:exchange_rates/src/core/widgets/visualize_chart.dart';
import 'package:exchange_rates/src/features/currency/data/models/currency_exchange_rate.dart';
import 'package:exchange_rates/src/features/currency_exchange_rate_details/logic/cubits/currency_exchange_rate_details_cubit.dart';
import 'package:flag/flag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CurrencyExchangeRateDetailsScreen extends StatefulWidget {
  const CurrencyExchangeRateDetailsScreen({super.key});

  static const routeName = '/currency-exchange-details-rate';

  @override
  State<CurrencyExchangeRateDetailsScreen> createState() =>
      _CurrencyExchangeRateDetailsScreenState();
}

class _CurrencyExchangeRateDetailsScreenState
    extends State<CurrencyExchangeRateDetailsScreen> {
  var _isInit = false;
  late CurrencyExchangeRate _currentExchangeRate;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _currentExchangeRate =
          ModalRoute.of(context)!.settings.arguments as CurrencyExchangeRate;
      context
          .read<CurrencyExchangeRateDetailsCubit>()
          .getCurrencyExchangeRateDetails(
              currencyCode: _currentExchangeRate.baseCurrencyCode);
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final baseCurrencyCode = _currentExchangeRate.baseCurrencyCode;
    final targetCurrencyCode = baseCurrencyCode == 'EGP' ? 'USD' : 'EGP';
    return Scaffold(
        appBar: AppBar(title: const Text('Details')),
        body: SafeArea(
          child: Center(
            child: BlocBuilder<CurrencyExchangeRateDetailsCubit,
                CurrencyExchangeRateDetailsState>(
              builder: (context, state) {
                if (state is CurrencyExchangeRateDetailsLoading) {
                  return const CircularProgressIndicator.adaptive();
                } else if (state is CurrencyExchangeRateDetailsFailedToLoad) {
                  return OnErrorRefreshButton(
                      failMsg: state.failMsg,
                      onRefreshPressed: () {
                        context
                            .read<CurrencyExchangeRateDetailsCubit>()
                            .getCurrencyExchangeRateDetails(
                                currencyCode: baseCurrencyCode);
                      });
                }
                final chartData =
                    context.read<CurrencyExchangeRateDetailsCubit>().chartData;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Spacer(),
                          Flag.fromCode(
                              baseCurrencyCode == 'EGP'
                                  ? FlagsCode.EG
                                  : FlagsCode.US,
                              height: Sizes.p30,
                              width: Sizes.p30 * 4 / 3,
                              borderRadius: Sizes.p4),
                          const Spacer(),
                          const Icon(Icons.compare_arrows_rounded),
                          const Spacer(),
                          Flag.fromCode(
                              targetCurrencyCode == 'USD'
                                  ? FlagsCode.US
                                  : FlagsCode.EG,
                              height: Sizes.p30,
                              width: Sizes.p30 * 4 / 3,
                              borderRadius: Sizes.p4),
                          const Spacer(),
                        ],
                      ),
                      gapH64,
                      Text(
                          '${AppSharedUtils.getCurrencySymbol(currencyCode: baseCurrencyCode)} 1 = ${AppSharedUtils.getCurrencySymbol(currencyCode: targetCurrencyCode)} ${_currentExchangeRate.exchangeRate}',
                          style: Theme.of(context).textTheme.titleLarge),
                      Column(
                        children: [
                          Text('Updated at',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context).hintColor)),
                          Text(
                              DateFormat.yMMMMd()
                                  .format(_currentExchangeRate.date),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context).hintColor)),
                          Text(
                              DateFormat.jm().format(_currentExchangeRate.date),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                      color: Theme.of(context).hintColor)),
                        ],
                      ),
                      VisualizeChart(
                        normalizedValues: chartData.normalizedValues,
                        minY: chartData.minExchangeRate,
                        maxY: chartData.maxExchangeRate,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
