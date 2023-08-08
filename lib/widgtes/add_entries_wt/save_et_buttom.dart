import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/provider/ui_provider.dart';
import 'package:gastos/utils/constants.dart';
import 'package:provider/provider.dart';

class SaveEtButtom extends StatelessWidget {
  final CombinedModel cModel;
  const SaveEtButtom({super.key, required this.cModel});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.00) {
          exProvider.addNewEntries(cModel);
          uiProvider.bnbIndex = 0;
          Navigator.pop(context);

          print('ingreso agregado');
        } else if (cModel.amount == 0.0) {
          print('olvidaste un Ingreso');
        }
      },
      child: SizedBox(
        height: 70.0,
        width: 160.0,
        child: Constants.customButtom(Colors.green, Colors.white, 'GUARDAR'),
      ),
    );
  }
}
