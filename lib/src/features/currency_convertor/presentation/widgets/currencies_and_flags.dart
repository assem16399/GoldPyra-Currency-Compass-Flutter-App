import 'package:flag/flag.dart';
import 'package:flutter/material.dart';

import '/src/core/constants/app_sizes.dart';

class CurrenciesAndFlags extends StatelessWidget {
  const CurrenciesAndFlags({super.key});

  @override
  Widget build(BuildContext context) {
    const flagRatio = Sizes.p30;
    const borderRadius = Sizes.p4;
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p24, vertical: Sizes.p8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flag.fromCode(FlagsCode.EG,
                  height: flagRatio,
                  width: flagRatio * 4 / 3,
                  borderRadius: borderRadius),
              gapW16,
              Text('EGP', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Sizes.p24, vertical: Sizes.p8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flag.fromCode(FlagsCode.US,
                  height: flagRatio,
                  width: flagRatio * 4 / 3,
                  borderRadius: borderRadius),
              gapW16,
              Text('USD', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        )
      ],
    );
  }
}
