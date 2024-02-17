import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import '/src/core/constants/app_sizes.dart';

class ExchangeRatesListItem extends StatelessWidget {
  const ExchangeRatesListItem({
    super.key,
    required this.baseCurrencyCode,
    required this.correspondingCurrencyCode,
    required this.rate,
    required this.baseCountryCode,
    required this.correspondingCountryCode,
  });

  final String baseCurrencyCode;
  final String baseCountryCode;
  final String correspondingCurrencyCode;
  final String correspondingCountryCode;
  final double rate;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Flags.fromString(
        [correspondingCountryCode, baseCountryCode],
        height: Sizes.p30,
        width: Sizes.p30 * 4 / 3,
        borderRadius: Sizes.p4,
      ),
      title: Text('$baseCurrencyCode/$correspondingCurrencyCode'),
      trailing:
          Text(rate.toString(), style: Theme.of(context).textTheme.bodyLarge),
      subtitle: Text('1$baseCurrencyCode'),
    );
  }
}
