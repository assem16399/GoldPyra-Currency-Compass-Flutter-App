import 'package:exchange_rates/src/core/utils/app_shared_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/features/currency_convertor/data/models/amount_exchange_rate.dart';
import '/src/features/currency_convertor/logic/cubits/amount_exchange_rate_cubit.dart';

class CurrencyConvertor extends StatefulWidget {
  const CurrencyConvertor({super.key, required this.amountExchangeRate});

  final AmountExchangeRate amountExchangeRate;
  @override
  State<CurrencyConvertor> createState() => _CurrencyConvertorState();
}

class _CurrencyConvertorState extends State<CurrencyConvertor> {
  late final TextEditingController _baseAmountTextController;
  late final TextEditingController _correspondingAmountTextController;
  late AmountExchangeRate _amountExchangeRate;

  @override
  void initState() {
    super.initState();
    _amountExchangeRate = widget.amountExchangeRate;

    _baseAmountTextController =
        TextEditingController(text: _amountExchangeRate.formattedAmount);

    _correspondingAmountTextController = TextEditingController(
        text: _amountExchangeRate.formattedAmountInBaseCurrency);
  }

  void _swapControllersValues() {
    final tempAmount = _baseAmountTextController.text;
    _baseAmountTextController.text = _correspondingAmountTextController.text;
    _correspondingAmountTextController.text = tempAmount;
  }

  void _updateAmountExchangeRateAfterSwapping() {
    _swapControllersValues();
    final currencyExchangeRateAfterSwapping =
        _amountExchangeRate.currencyExchangeRate.copyWith(
      baseCurrencyCode:
          _amountExchangeRate.currencyExchangeRate.correspondingCurrencyCode,
      correspondingCurrencyCode:
          _amountExchangeRate.currencyExchangeRate.baseCurrencyCode,
    );
    _amountExchangeRate = _amountExchangeRate.copyWith(
        currencyExchangeRate: currencyExchangeRateAfterSwapping,
        amount: double.tryParse(_baseAmountTextController.text) ?? 0);
  }

  void _resetControllersToZero() {
    _baseAmountTextController.text = '';
    _correspondingAmountTextController.text = '';
  }

  void _handleEmptyBaseAmount() {
    _resetControllersToZero();

    _amountExchangeRate = _amountExchangeRate.copyWith(amount: 0);

    context
        .read<AmountExchangeRateCubit>()
        .updateAmountExchangeRate(_amountExchangeRate);
  }

  void _calculateCorrespondingAmount() {
    _amountExchangeRate = _amountExchangeRate.copyWith(
        amount: double.parse(_baseAmountTextController.text));

    _correspondingAmountTextController.text =
        _amountExchangeRate.formattedAmountInBaseCurrency;

    context
        .read<AmountExchangeRateCubit>()
        .updateAmountExchangeRate(_amountExchangeRate);
  }

  @override
  Widget build(BuildContext context) {
    final currencyExchangeRate = widget.amountExchangeRate.currencyExchangeRate;
    return Row(
      children: [
        Expanded(
          child: TextField(
            onTapOutside: (_) => FocusScope.of(context).unfocus(),
            autofocus: true,
            controller: _baseAmountTextController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,99}'))
            ],
            decoration: InputDecoration(
              suffix: Text(AppSharedUtils.getCurrencySymbol(
                  currencyCode: currencyExchangeRate.baseCurrencyCode)),
            ),
            onChanged: (value) {
              if (value.isEmpty) {
                _handleEmptyBaseAmount();
                return;
              } else {
                _calculateCorrespondingAmount();
              }
            },
          ),
        ),
        IconButton(
            onPressed: () {
              _updateAmountExchangeRateAfterSwapping();
              context
                  .read<AmountExchangeRateCubit>()
                  .updateAmountExchangeRateOnline(_amountExchangeRate);
            },
            icon: const Icon(CupertinoIcons.arrow_right_arrow_left)),
        Expanded(
          child: TextField(
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              controller: _correspondingAmountTextController,
              readOnly: true,
              decoration: InputDecoration(
                suffix: Text(AppSharedUtils.getCurrencySymbol(
                    currencyCode:
                        currencyExchangeRate.correspondingCurrencyCode)),
              )),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _baseAmountTextController.dispose();
    _correspondingAmountTextController.dispose();
  }
}
