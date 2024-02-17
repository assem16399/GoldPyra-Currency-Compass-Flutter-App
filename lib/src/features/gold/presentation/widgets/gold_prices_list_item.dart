import 'package:exchange_rates/src/core/constants/app_sizes.dart';
import 'package:flutter/material.dart';

class GoldPricesListItem extends StatelessWidget {
  const GoldPricesListItem(
      {super.key,
      required this.currency,
      required this.goldType,
      required this.price});

  final String currency;
  final int goldType;
  final double price;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: Sizes.p40,
        height: Sizes.p20,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red.shade400, width: 2.5),
          borderRadius: BorderRadius.circular(Sizes.p4),
          gradient: const LinearGradient(
            colors: [Colors.yellow, Color(0xffad9c00)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
      title: Text('${goldType}K/$currency'),
      trailing: Text(
        price.toString(),
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      subtitle: const Text('1gm'),
    );
  }
}
