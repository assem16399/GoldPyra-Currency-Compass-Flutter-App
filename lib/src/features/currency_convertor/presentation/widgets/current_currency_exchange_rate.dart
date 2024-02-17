import 'package:exchange_rates/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class CurrentCurrencyExchangeRate extends StatelessWidget {
  const CurrentCurrencyExchangeRate({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              '1 EGP equals',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            const Icon(Icons.currency_exchange_outlined)
          ],
        ),
        gapH16,
        Text(
          '15.6 USD',
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
