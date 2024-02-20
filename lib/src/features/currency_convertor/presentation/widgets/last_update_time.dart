import 'package:exchange_rates/src/features/currency_convertor/logic/cubits/amount_exchange_rate_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class LastUpdateTime extends StatelessWidget {
  const LastUpdateTime({super.key, required this.lastUpdateTime});

  final DateTime lastUpdateTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Update time: ${DateFormat('yyyy-MM-dd hh:mm a').format(lastUpdateTime)}',
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).hintColor),
        ),
        const Spacer(),
        IconButton(
          onPressed:
              context.read<AmountExchangeRateCubit>().getPairExchangeRate,
          icon: const Icon(Icons.refresh),
        )
      ],
    );
  }
}
