import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/widgtes/add_entries_wt/save_et_buttom.dart';

import 'package:gastos/widgtes/add_expenses_wt/bs_num_keybpard.dart';
import 'package:gastos/widgtes/add_expenses_wt/comment_box.dart';
import 'package:gastos/widgtes/add_expenses_wt/date_picker.dart';

class AddEntries extends StatelessWidget {
  const AddEntries({super.key});

  @override
  Widget build(BuildContext context) {
    CombinedModel cModel = CombinedModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Ingreso'),
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
                  CommentBox(cModel: cModel),
                  Expanded(
                    child: Center(
                      child: SaveEtButtom(
                        cModel: cModel,
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
