import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import '/src/core/constants/app_sizes.dart';

class CurrenciesAndFlags extends StatelessWidget {
  const CurrenciesAndFlags({super.key, required this.isEGPBaseCurrency});

  final bool isEGPBaseCurrency;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FlagAndCurrency(
          flagsCode: isEGPBaseCurrency ? FlagsCode.EG : FlagsCode.US,
          currencyCode: isEGPBaseCurrency ? 'EGP' : 'USD',
        ),
        const Spacer(),
        FlagAndCurrency(
          flagsCode: isEGPBaseCurrency ? FlagsCode.US : FlagsCode.EG,
          currencyCode: isEGPBaseCurrency ? 'USD' : 'EGP',
        ),
      ],
    );
  }
}

class FlagAndCurrency extends StatelessWidget {
  const FlagAndCurrency({
    super.key,
    required this.flagsCode,
    required this.currencyCode,
  });

  final FlagsCode flagsCode;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    const flagRatio = Sizes.p30;
    const borderRadius = Sizes.p4;
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: Sizes.p24, vertical: Sizes.p8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Flag.fromCode(flagsCode,
              height: flagRatio,
              width: flagRatio * 4 / 3,
              borderRadius: borderRadius),
          gapW16,
          Text(currencyCode, style: Theme.of(context).textTheme.headlineSmall),
        ],
      ),
    );
  }
}
