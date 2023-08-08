import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/utils/math_operations.dart';
import 'package:gastos/widgtes/balance_page_wt/back_sheet.dart';
import 'package:gastos/widgtes/balance_page_wt/custom_fab.dart';
import 'package:gastos/widgtes/balance_page_wt/front_sheet.dart';
import 'package:gastos/widgtes/balance_page_wt/month_selector.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  final _scrollController = ScrollController();
  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      print(_max);
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    _max;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  double get _max => max(90 - _offset * 90, 0.0);

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;

    return Scaffold(
      floatingActionButton: const CustomFAB(),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 130.0,
            elevation: 0.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const MonthSelector(),
                  Text(getBalance(eList, etList),
                      style:
                          const TextStyle(fontSize: 30.0, color: Colors.green)),
                  const Text(
                    'Balance',
                    style: TextStyle(fontSize: 14.0),
                  )
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                children: [
                  const BackSheer(),
                  Padding(
                    padding: EdgeInsets.only(top: _max),
                    child: const FrontSheet(),
                  ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
