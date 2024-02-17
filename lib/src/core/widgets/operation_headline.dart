import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OperationHeadLine extends StatelessWidget {
  const OperationHeadLine(
      {super.key, required this.operation, required this.date});

  final String operation;
  final DateTime date;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(operation)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(DateFormat.yMMMMd().format(date)),
              Text(DateFormat.jm().format(date)),
            ],
          ),
        )
      ],
    );
  }
}
