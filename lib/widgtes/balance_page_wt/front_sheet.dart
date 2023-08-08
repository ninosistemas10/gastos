import 'package:flutter/material.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/widgtes/balance_page_wt/flayer_category.dart';
import 'package:gastos/widgtes/balance_page_wt/flayer_skin.dart';
import 'package:provider/provider.dart';

class FrontSheet extends StatelessWidget {
  const FrontSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final eeList = context.watch<ExpensesProvider>().eList;
    bool hasData = false;

    if (eeList.isNotEmpty) {
      hasData = true;
    }

    return Container(
        //height: 800,
        decoration: Constants.sheetBoxDecoration(
            Theme.of(context).scaffoldBackgroundColor),
        child: (hasData)
            ? ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  FlayerSkin(
                      myTitle: 'Categoria de Gastos',
                      myWidget: FlayerCategory()),
                  FlayerSkin(
                      myTitle: 'Categoria de Gastos',
                      myWidget: SizedBox(height: 150.0)),
                  FlayerSkin(
                      myTitle: 'Categoria de Gastos',
                      myWidget: SizedBox(height: 150.0)),
                  FlayerSkin(
                      myTitle: 'Categoria de Gastos',
                      myWidget: SizedBox(height: 150.0)),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(50),
                    child: Image.asset('assets/empty.png'),
                  ),
                  const Text(
                    'No tienes gastos este mes,agrega aqui 👇',
                    maxLines: 1,
                    style: TextStyle(fontSize: 15.0, letterSpacing: 1.3),
                  )
                ],
              ));
  }
}
