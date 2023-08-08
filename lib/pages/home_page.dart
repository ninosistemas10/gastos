import 'package:flutter/material.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:provider/provider.dart';

import 'package:gastos/provider/ui_provider.dart';
import 'package:gastos/pages/balance_page.dart';
import 'package:gastos/pages/charts_page.dart';
import 'package:gastos/widgtes/home_page_wt/custom_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: _HomePage(),
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final exProvider = context.read<ExpensesProvider>();
    final DateTime ddate = DateTime.now();

    final currentIndex = uiProvider.bnbIndex;
    final currentMonth = uiProvider.selectedMonth + 1;

    switch (currentIndex) {
      case 0:
        exProvider.getEntriesByDate(currentMonth, ddate.year);
        exProvider.getExpensesByDate(currentMonth, ddate.year);
        exProvider.getAllListeners();

        return const BalancePage();
      case 1:
        return const ChartsPage();
      default:
        return const BalancePage();
    }
  }
}
