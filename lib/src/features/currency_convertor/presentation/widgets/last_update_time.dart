import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdateTime extends StatelessWidget {
  const LastUpdateTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Update time: ${DateFormat('yyyy-MM-dd hh:mm a').format(DateTime.now())}',
          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).hintColor,
              ),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.refresh),
        )
      ],
    );
  }
}
