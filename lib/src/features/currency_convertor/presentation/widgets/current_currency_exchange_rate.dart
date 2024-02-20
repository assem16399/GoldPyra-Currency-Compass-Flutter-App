import 'package:exchange_rates/src/core/constants/app_sizes.dart';
import 'package:exchange_rates/src/features/currency_convertor/data/models/amount_exchange_rate.dart';
import 'package:flutter/material.dart';

class CurrentCurrencyExchangeRate extends StatelessWidget {
  const CurrentCurrencyExchangeRate(
      {super.key, required this.amountExchangeRate});

  final AmountExchangeRate amountExchangeRate;
  @override
  Widget build(BuildContext context) {
    final currencyExchangeRate = amountExchangeRate.currencyExchangeRate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '1 ${currencyExchangeRate.baseCurrencyCode} equals',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            const Icon(Icons.currency_exchange_outlined)
          ],
        ),
        gapH16,
        Text(
          '${amountExchangeRate.exchangeRateInBaseCurrency.toStringAsFixed(2)} ${currencyExchangeRate.correspondingCurrencyCode}',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
