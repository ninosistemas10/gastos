import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:gastos/models/feature_model.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/utils/utils.dart';
import 'package:gastos/widgtes/add_expenses_wt/create_category.dart';

class AdminCategory extends StatelessWidget {
  const AdminCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;
    return ListView.builder(
      itemCount: fList.length,
      itemBuilder: (context, i) {
        var item = fList[i];

        return ListTile(
          leading: Icon(
            item.icon.toIcons(),
            size: 35.0,
            color: item.color.toColor(),
          ),
          title: Text(item.category),
          trailing: const Icon(
            Icons.edit,
            size: 25.0,
          ),
          onTap: () {
            Navigator.pop(context);
            _createCategory(context, item);
          },
        );
      },
    );
  }

  _createCategory(BuildContext context, FeatureModel fModel) {
    var feature = FeatureModel(
        id: fModel.id,
        category: fModel.category,
        color: fModel.color,
        icon: fModel.icon);

    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        context: context,
        builder: (_) => CreateCategory(fModel: feature));
  }
}
