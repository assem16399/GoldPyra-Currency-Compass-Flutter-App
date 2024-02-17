import 'package:flutter/material.dart';

import '../widgets/currencies_and_flags.dart';
import '../widgets/currency_convertor.dart';
import '../widgets/current_currency_exchange_rate.dart';
import '../widgets/last_update_time.dart';
import '/src/core/constants/app_sizes.dart';

class CurrencyConvertorScreen extends StatelessWidget {
  const CurrencyConvertorScreen({super.key});

  static const routeName = '/currency-convertor';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Currency Convertor')),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CurrentCurrencyExchangeRate(),
              gapH32,
              LastUpdateTime(),
              gapH32,
              CurrenciesAndFlags(),
              gapH16,
              CurrencyConvertor(),
            ],
          ),
        ),
      ),
    );
  }
}
