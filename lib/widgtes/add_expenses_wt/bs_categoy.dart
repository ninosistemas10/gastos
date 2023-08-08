import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/models/feature_model.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/utils/utils.dart';
import 'package:gastos/widgtes/add_expenses_wt/admin_category.dart';
import 'package:gastos/widgtes/add_expenses_wt/category_list.dart';
import 'package:gastos/widgtes/add_expenses_wt/create_category.dart';
import 'package:provider/provider.dart';

class BSCategory extends StatefulWidget {
  final CombinedModel cModel;
  const BSCategory({super.key, required this.cModel});

  @override
  State<BSCategory> createState() => _BSCategoryState();
}

class _BSCategoryState extends State<BSCategory> {
  var catList = CategoryList().catList;
  final FeatureModel fModel = FeatureModel();

  @override
  void initState() {
    var exProvider = context.read<ExpensesProvider>();
    if (exProvider.fList.isEmpty) {
      for (FeatureModel e in catList) {
        exProvider.addNewFeature(e.category, e.color, e.icon);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final featureList = context.watch<ExpensesProvider>().fList;

    bool hasData = false;

    if (widget.cModel.category != 'Selecciona Categoria') {
      hasData = true;
    }

    return GestureDetector(
      onTap: () {
        _categorySelected(featureList);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          children: [
            const Icon(Icons.category_outlined, size: 35.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 1.7,
                        color: (hasData)
                            ? widget.cModel.color.toColor()
                            : Theme.of(context).dividerColor),
                    borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Text(widget.cModel.category),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _categorySelected(List<FeatureModel> fList) {
    void iitemSelected(String category, String color, int link) {
      setState(() {
        widget.cModel.category = category;
        widget.cModel.color = color;
        widget.cModel.link = link;
        //Navigator.pop(context);
      });
    }

    var wwidget = [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fList.length,
          itemBuilder: (_, i) {
            var item = fList[i];
            return ListTile(
              leading: Icon(
                item.icon.toIcons(),
                color: item.color.toColor(),
                size: 35.0,
              ),
              title: Text(item.category),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15.0,
              ),
              onTap: () {
                iitemSelected(item.category, item.color, item.id!);
                Navigator.pop(context);
              },
            );
          }),
      const Divider(thickness: 2.0),
      ListTile(
        leading: const Icon(Icons.create_new_folder_outlined),
        title: const Text('Crear nueva categoria'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () {
          Navigator.pop(context);
          _createNewCategory();
        },
      ),
      ListTile(
        leading: const Icon(Icons.edit_outlined),
        title: const Text('Administrar categoria'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 15),
        onTap: () {
          Navigator.pop(context);
          _adminCategory();
        },
      ),
    ];

    showModalBottomSheet(
        shape: Constants.bottomSheet(),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: ListView(children: wwidget),
          );
        });
  }

  _createNewCategory() {
    var feature = FeatureModel(
        id: fModel.id,
        category: fModel.category,
        color: fModel.color,
        icon: fModel.icon);
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isScrollControlled: true,
      isDismissible: false,
      context: context,
      builder: (context) => CreateCategory(fModel: feature),
    );
  }

  _adminCategory() {
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      //isScrollControlled: true,
      context: context,
      builder: (context) => const AdminCategory(),
    );
  }
}
