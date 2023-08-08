import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:provider/provider.dart';

import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/utils/utils.dart';

class FlayerCategory extends StatelessWidget {
  const FlayerCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final exProvider = context.watch<ExpensesProvider>();
    final gList = exProvider.groupItemList;
    List<CombinedModel> limitList = [];
    bool hasLimit = false;

    if (gList.length >= 6) {
      limitList = gList.sublist(0, 5);
      hasLimit = true;
    }

    if (limitList.length == 5) {
      limitList.add(
          CombinedModel(category: 'Otros...', icon: 'otros', color: '#20634b'));
    }

    //  return Container();

    return Row(
      children: [
        Expanded(
          flex: 2,
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), //no scroll
              itemCount: (hasLimit) ? limitList.length : gList.length,
              itemBuilder: (_, i) {
                var item = gList[i];
                if (hasLimit == true) item = limitList[i];

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      'cat_details',
                      arguments: item,
                    );
                  },
                  child: ListTile(
                    dense: true, // se junta verticalmente
                    visualDensity: const VisualDensity(vertical: -4),
                    horizontalTitleGap: -10, // quita el padding
                    leading: Icon(
                      item.icon.toIcons(),
                      color: item.color.toColor(),
                    ),
                    title: Text(
                      item.category,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                    //trailing: Text(getAmountformat(item.amount)),
                  ),
                );
              }),
        ),
        const Expanded(
          flex: 3,
          child: CircleColor(color: Colors.green, circleSize: 150),
        ),
      ],
    );
  }
}
