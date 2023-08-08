import 'package:flutter/material.dart';
import 'package:gastos/models/feature_model.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/utils/constants.dart';
import 'package:gastos/utils/icon_list.dart';
import 'package:gastos/utils/utils.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';

class CreateCategory extends StatefulWidget {
  final FeatureModel fModel;

  const CreateCategory({super.key, required this.fModel});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  bool hasData = false;
  String stcCategoria = ''; // static category
  @override
  void initState() {
    if (widget.fModel.id != null) {
      stcCategoria = widget.fModel.category; //cacho el valor y no redibujo
      hasData = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fList = context.watch<ExpensesProvider>().fList;
    final exProvider = context.read<ExpensesProvider>();

    final viewInsets = MediaQuery.of(context).viewInsets.bottom;

    Iterable<FeatureModel> contain;

    contain = fList.where(
      (e) => e.category.toLowerCase() == widget.fModel.category.toLowerCase(),
    );

    aaddCategory() {
      if (contain.isNotEmpty) {
        print('ya existe');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.addNewFeature(
            widget.fModel.category, widget.fModel.color, widget.fModel.icon);
        Navigator.pop(context);
        print('Procede a Guardar');
      } else {
        print('No olvides nombrar una categoria');
      }
    }

    eeditarCategory() {
      if (widget.fModel.category.toLowerCase() == stcCategoria.toLowerCase()) {
        exProvider.updateFeature(widget.fModel);
        Navigator.pop(context);
        print('Procede a editar');
      } else if (contain.isNotEmpty) {
        print('Ya existe la categoria');
      } else if (widget.fModel.category.isNotEmpty) {
        exProvider.updateFeature(widget.fModel);
        Navigator.pop(context);
        print('ya se edito cambios');
      } else {
        print('No olvides nombrar la categoria editada');
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: viewInsets / 3),
              child: ListTile(
                trailing: const Icon(Icons.text_fields_outlined, size: 35.0),
                title: TextFormField(
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  initialValue: widget.fModel.category,
                  decoration: InputDecoration(
                      hintText: 'Nombra una categoria',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0))),
                  onChanged: (texto) {
                    widget.fModel.category = texto;
                  },
                ),
              ),
            ),
            ListTile(
              onTap: () => _selectColor(context),
              trailing: CircleColor(
                  color: widget.fModel.color.toColor(), circleSize: 35.0),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(35.0)),
                child: const Center(
                  child: Text('Color'),
                ),
              ),
            ),
            ListTile(
              onTap: () => _selectIcon(),
              trailing: Icon(widget.fModel.icon.toIcons(), size: 35),
              title: Container(
                padding: const EdgeInsets.all(18.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).cardColor),
                    borderRadius: BorderRadius.circular(35.0)),
                child: const Center(
                  child: Text('Icons'),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Constants.customButtom(
                      Colors.transparent,
                      Colors.red,
                      'CANCELAR',
                    ),
                  ),
                ),
                Expanded(
                    child: GestureDetector(
                  onTap: () {
                    (hasData) ? eeditarCategory() : aaddCategory();
                  },
                  child: Constants.customButtom(
                    Colors.green,
                    Colors.transparent,
                    'ACEPTAR',
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }

  _selectColor(BuildContext context) {
    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MaterialColorPicker(
              selectedColor: widget.fModel.color.toColor(),
              physics: const NeverScrollableScrollPhysics(),
              circleSize: 50,
              onColorChange: (Color color) {
                var hexColor =
                    '#${color.value.toRadixString(16).substring(2, 8)}';
                setState(() {
                  widget.fModel.color = hexColor;
                });
              },
              //allowShades: false,
              //iconSelected: Icons.ac_unit,
              //colors: fullMaterialColors,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Constants.customButtom(
                  Colors.green, Colors.transparent, 'LISTO'),
            ),
          ],
        );
      },
    );
  }

  _selectIcon() {
    final iconList = IconList().iconMap;

    showModalBottomSheet(
      shape: Constants.bottomSheet(),
      isDismissible: false,
      context: context,
      builder: (context) {
        return SizedBox(
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5),
              itemCount: iconList.length,
              itemBuilder: (context, i) {
                var key = iconList.keys.elementAt(i);
                return GestureDetector(
                  child: Icon(
                    key.toIcons(),
                    size: 30.0,
                    color: Theme.of(context).dividerColor,
                  ),
                  onTap: () {
                    setState(() {
                      widget.fModel.icon = key;
                      Navigator.pop(context);
                    });
                  },
                );
              }),
        );
      },
    );
  }
}
