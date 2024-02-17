import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CurrencyConvertor extends StatelessWidget {
  const CurrencyConvertor({super.key});
  String getEGPCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'EGP');
    return format.currencySymbol;
  }

  String getUSDCurrency() {
    var format =
        NumberFormat.simpleCurrency(locale: Platform.localeName, name: 'USD');
    return format.currencySymbol;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              autofocus: true,
              controller: TextEditingController(text: '0.0'),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                suffix: Text(getEGPCurrency()),
              )),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.arrow_right_arrow_left)),
        Expanded(
          child: TextField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              controller: TextEditingController(text: '0.0'),
              readOnly: true,
              decoration: InputDecoration(
                suffix: Text(getUSDCurrency()),
              )),
        ),
      ],
    );
  }
}
