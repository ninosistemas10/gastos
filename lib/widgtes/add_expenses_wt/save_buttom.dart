import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/provider/ui_provider.dart';
import 'package:gastos/utils/constants.dart';
import 'package:provider/provider.dart';

class SaveButtom extends StatelessWidget {
  final CombinedModel cModel;
  final bool hasData;
  const SaveButtom({super.key, required this.cModel, required this.hasData});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.read<ExpensesProvider>();
    final uiProvider = context.read<UIProvider>();

    return GestureDetector(
      onTap: () {
        if (cModel.amount != 0.00 && cModel.link != null) {
          (hasData)
              ? exProvider.updateExpense(cModel)
              : exProvider.addNewExpense(cModel);

          (hasData) ? print('Gasto Editado') : print('Gasto agregado');
          uiProvider.bnbIndex = 0;
          //Navigator.pop(context);
        } else if (cModel.amount == 0.0) {
          print('olvidaste el monto');
        } else {
          print('no olvides seleccionar una categoria');
        }
        Navigator.pop(context);
      },
      child: SizedBox(
        height: 70.0,
        width: 160.0,
        child: Constants.customButtom(
            Colors.green, Colors.white, (hasData) ? 'EDITAR' : 'GUARDAR'),
      ),
    );
  }
}
