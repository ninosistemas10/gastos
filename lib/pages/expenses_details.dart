import 'package:flutter/material.dart';

import 'package:gastos/models/combined_model.dart';
import 'package:gastos/provider/ui_provider.dart';
import 'package:gastos/utils/math_operations.dart';
import 'package:gastos/utils/utils.dart';
import 'package:provider/provider.dart';

import 'package:gastos/provider/expenses_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpensesDetails extends StatefulWidget {
  const ExpensesDetails({super.key});

  @override
  State<ExpensesDetails> createState() => _ExpensesDetailsState();
}

class _ExpensesDetailsState extends State<ExpensesDetails> {
  List<CombinedModel> cList = [];

  final _scrollController = ScrollController();

  double _offset = 0;

  void _listener() {
    setState(() {
      _offset = _scrollController.offset / 100;
      print(_offset);
    });
  }

  @override
  void initState() {
    _scrollController.addListener(_listener);
    cList = context.read<ExpensesProvider>().allitemList;
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_listener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();
    cList = context.watch<ExpensesProvider>().allitemList;

    double totalExp = 0.00;
    totalExp = cList.map((e) => e.amount).fold(0.00, (a, b) => a + b);

    if (_offset > 0.95) _offset = 0.95;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            expandedHeight: 125.0,
            title: const Text(
              'Desglose de gastos',
              style: TextStyle(color: Colors.orange),
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Align(
                  alignment: Alignment(_offset, 1),
                  child: Text(getAmountformat(totalExp))),
              centerTitle: true,
              background: const Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Text(
                  'Total',
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ),

          // SliverToBoxAdapter(
          //   child: Container(
          //     padding: const EdgeInsets.only(top: 15.0),
          //          height: 40.0,
          //          color: Theme.of(context).scaffoldBackgroundColor,
          //          child: Container(
          //            decoration: Constants.sheetBoxDecoration(
          //                Theme.of(context).primaryColorDark),
          //   ),
          // ),

          SliverList(
            delegate: SliverChildBuilderDelegate((context, i) {
              var item = cList[i];

              return Slidable(
                key: ValueKey(item),
                startActionPane: ActionPane(
                  motion: const BehindMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {
                        setState(() {
                          cList.removeAt(i);
                        });
                        exProvider.deleteExpense(item.id!);
                        uiProvider.bnbIndex = 0;
                        print('Gasto Eliminado');
                      },
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Borrar',
                    ),
                    SlidableAction(
                      onPressed: (context) {
                        Navigator.pushNamed(context, 'add_expenses',
                            arguments: item);
                      },
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      icon: Icons.edit,
                      label: 'Editar',
                    )
                  ],
                ),
                child: ListTile(
                  leading:
                      Stack(alignment: AlignmentDirectional.center, children: [
                    const Icon(
                      Icons.calendar_today,
                      size: 40.0,
                    ),
                    Positioned(top: 14, child: Text(item.day.toString()))
                  ]),
                  title: Row(children: [
                    Text(item.category),
                    const SizedBox(width: 10.0),
                    Icon(
                      item.icon.toIcons(),
                      color: item.color.toColor(),
                      size: 22.0,
                    )
                  ]),
                  subtitle: Text(
                    item.comment,
                    style: TextStyle(color: item.color.toColor()),
                  ),
                  trailing: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          getAmountformat(item.amount),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '${(100 * item.amount / totalExp).toStringAsFixed(2)}%',
                          style: TextStyle(
                              fontSize: 11.0, color: item.color.toColor()),
                        )
                      ]),
                ),
              );
            }, childCount: cList.length),
          ),
        ],
      ),
    );
  }
}
