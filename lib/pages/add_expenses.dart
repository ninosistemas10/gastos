import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/widgtes/add_expenses_wt/bs_categoy.dart';
import 'package:gastos/widgtes/add_expenses_wt/bs_num_keybpard.dart';
import 'package:gastos/widgtes/add_expenses_wt/comment_box.dart';
import 'package:gastos/widgtes/add_expenses_wt/date_picker.dart';
import 'package:gastos/widgtes/add_expenses_wt/save_buttom.dart';

class AddExpenses extends StatelessWidget {
  const AddExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    bool hasData = false;

    final editCModel =
        ModalRoute.of(context)!.settings.arguments as CombinedModel?;
    if (editCModel != null) {
      cModel = editCModel;
      hasData = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: (hasData)
            ? const Text('Editar Gasto')
            : const Text('Agregar Gasto'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          BSNumKeyboard(
            cModel: cModel,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: Constants.sheetBoxDecoration(
                  Theme.of(context).primaryColorDark),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DatePicker(cModel: cModel),
                  BSCategory(cModel: cModel),
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                      child: SaveButtom(
                        cModel: cModel, hasData: hasData,
                        // print('Gasto: ${cModel.amount}');
                        //print('Fecha: ${cModel.year}/${cModel.month}/${cModel.day}');
                        //print('Comentario: ${cModel.comment}');
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
