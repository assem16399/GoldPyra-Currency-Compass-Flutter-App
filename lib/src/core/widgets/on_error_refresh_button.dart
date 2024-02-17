import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

class OnErrorRefreshButton extends StatelessWidget {
  const OnErrorRefreshButton(
      {super.key, required this.failMsg, required this.onRefreshPressed});

  final VoidCallback onRefreshPressed;
  final String failMsg;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(failMsg, textAlign: TextAlign.center),
              gapH16,
              IconButton(
                  onPressed: onRefreshPressed, icon: const Icon(Icons.refresh)),
            ],
          ),
        ),
      ],
    );
  }
}
