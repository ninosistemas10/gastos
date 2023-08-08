import 'package:flutter/material.dart';
import 'package:gastos/pages/entries_details.dart';
import 'package:gastos/pages/expenses_details.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/utils/math_operations.dart';
import 'package:gastos/utils/page_animation_routes.dart';
import 'package:provider/provider.dart';

import '../../provider/expenses_provider.dart';

class BackSheer extends StatelessWidget {
  const BackSheer({super.key});

  @override
  Widget build(BuildContext context) {
    final eList = context.watch<ExpensesProvider>().eList;
    final etList = context.watch<ExpensesProvider>().etList;

    header(String name, String amount, Color color) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13.0, bottom: 5.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 18.0, letterSpacing: 1.5),
            ),
          ),
          Text(
            amount,
            style: TextStyle(fontSize: 20.0, letterSpacing: 1.5, color: color),
          )
        ],
      );
    }

    return Container(
      height: 200,
      decoration:
          Constants.sheetBoxDecoration(Theme.of(context).primaryColorDark),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageAnimationRoute(
                        widget: const EntriesDetails(),
                        ejeX: -0.5,
                        ejeY: -0.5));
              },
              child: header('Ingresos',
                  getAmountformat(getSumOfEntries(etList)), Colors.green)),
          const VerticalDivider(
            thickness: 2.0,
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageAnimationRoute(
                        widget: const ExpensesDetails(),
                        ejeX: 0.5,
                        ejeY: -0.5));
              },
              child: header('Gastos  ',
                  getAmountformat(getSumOfExPenses(eList)), Colors.red))
        ],
      ),
    );
  }
}
