import 'package:exchange_rates/src/features/currency_convertor/logic/cubits/amount_exchange_rate_cubit.dart';
import 'package:exchange_rates/src/features/currency_exchange_rate_details/logic/cubits/currency_exchange_rate_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/src/features/gold/logic/cubits/gold_prices_cubit.dart';
import '/src/layout/app_layout.dart';
import 'dependency_injection/injection_container.dart' as sl;
import 'features/currency/logic/cubit/currency_exchange_rate_cubit.dart';
import 'features/currency_convertor/presentation/screens/currency_convertor_screen.dart';
import 'features/currency_exchange_rate_details/presentation/screens/currency_exchange_rate_details_screen.dart';

class ExchangeRates extends StatelessWidget {
  const ExchangeRates({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CurrencyExchangeRateCubit>(
            create: (context) => sl.sl<CurrencyExchangeRateCubit>()),
        BlocProvider<GoldPricesCubit>(
            create: (context) => sl.sl<GoldPricesCubit>()),
        BlocProvider<AmountExchangeRateCubit>(
            create: (context) => sl.sl<AmountExchangeRateCubit>()),
        BlocProvider<CurrencyExchangeRateDetailsCubit>(
            create: (context) => sl.sl<CurrencyExchangeRateDetailsCubit>()),
      ],
      child: MaterialApp(
        title: 'GoldPyra: Currency Compass',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: const Color(0xff1F1F1F),
            appBarTheme: const AppBarTheme().copyWith(
              backgroundColor: const Color(0xff1F1F1F),
            ),
            bottomNavigationBarTheme:
                const BottomNavigationBarThemeData().copyWith(
              backgroundColor: const Color(0xff1F1F1F),
            )),
        routes: {
          '/': (context) => const AppLayout(),
          CurrencyConvertorScreen.routeName: (context) =>
              const CurrencyConvertorScreen(),
          CurrencyExchangeRateDetailsScreen.routeName: (context) =>
              const CurrencyExchangeRateDetailsScreen(),
        },
      ),
    );
  }
}
