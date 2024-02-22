import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../features/currency/presentation/tabs/currency_tab.dart';
import '../features/currency_convertor/presentation/screens/currency_convertor_screen.dart';
import '../features/gold/presentation/tabs/gold_tab.dart';

class AppLayout extends StatefulWidget {
  const AppLayout({super.key});

  @override
  State<AppLayout> createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  var _currentIndex = 0;
  final _tabs = const [CurrencyTab(), GoldTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GoldPyra: Currency Compass')),
      body: SafeArea(child: _tabs[_currentIndex]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(CurrencyConvertorScreen.routeName);
        },
        child: const Icon(Icons.currency_exchange_outlined),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar_circle),
              activeIcon: Icon(CupertinoIcons.money_dollar_circle_fill),
              label: 'Currency'),
          BottomNavigationBarItem(
            icon: Icon(Icons.area_chart_outlined),
            activeIcon: Icon(Icons.area_chart),
            label: 'Gold',
          ),
        ],
      ),
    );
  }
}
