import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubits/gold_prices_cubit.dart';
import '../widgets/gold_prices_list_item.dart';
import '/src/core/constants/app_sizes.dart';
import '/src/core/widgets/on_error_refresh_button.dart';

class GoldTab extends StatefulWidget {
  const GoldTab({super.key});

  @override
  State<GoldTab> createState() => _GoldTabState();
}

class _GoldTabState extends State<GoldTab> {
  @override
  void initState() {
    super.initState();
    context.read<GoldPricesCubit>().getGoldPrices();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>
          context.read<GoldPricesCubit>().refreshGoldPrices(),
      child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: BlocBuilder<GoldPricesCubit, GoldPricesState>(
            builder: (context, state) {
              if (state is GoldPricesLoading) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (state is GoldPricesFailedToLoad) {
                return OnErrorRefreshButton(
                    failMsg: state.failMsg,
                    onRefreshPressed:
                        context.read<GoldPricesCubit>().getGoldPrices);
              }
              final goldPrices = context.read<GoldPricesCubit>().goldPrices;
              final goldTapPricesListItems = [
                GoldPricesListItem(
                    goldType: 24, price: goldPrices.gold24kPrice),
                GoldPricesListItem(
                    goldType: 22, price: goldPrices.gold22kPrice),
                GoldPricesListItem(
                    goldType: 21, price: goldPrices.gold21kPrice),
                GoldPricesListItem(
                    goldType: 20, price: goldPrices.gold20kPrice),
                GoldPricesListItem(
                    goldType: 18, price: goldPrices.gold18kPrice),
                GoldPricesListItem(
                    goldType: 16, price: goldPrices.gold16kPrice),
                GoldPricesListItem(
                    goldType: 14, price: goldPrices.gold14kPrice),
                GoldPricesListItem(
                    goldType: 10, price: goldPrices.gold10kPrice),
              ];
              return ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) => goldTapPricesListItems[index],
                itemCount: goldTapPricesListItems.length,
              );
            },
          )),
    );
  }
}
