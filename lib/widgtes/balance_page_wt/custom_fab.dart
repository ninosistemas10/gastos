import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:gastos/pages/add_entries.dart';
import 'package:gastos/pages/add_expenses.dart';
import 'package:gastos/utils/page_animation_routes.dart';

class CustomFAB extends StatelessWidget {
  const CustomFAB({super.key});

  @override
  Widget build(BuildContext context) {
    List<SpeedDialChild> childButtons = [];

    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.cyan[700],
      child: const Icon(Icons.remove),
      label: 'Gasto',
      labelStyle: const TextStyle(fontSize: 16.0),
      onTap: () {
        Navigator.push(
            context,
            PageAnimationRoute(
                widget: const AddExpenses(), ejeX: 0.8, ejeY: 0.8));
      },
    ));

    childButtons.add(SpeedDialChild(
      backgroundColor: Colors.green,
      child: const Icon(Icons.add),
      label: 'Ingreso',
      labelStyle: const TextStyle(fontSize: 16.0),
      onTap: () {
        Navigator.push(
            context,
            PageAnimationRoute(
                widget: const AddEntries(), ejeX: 0.8, ejeY: 0.8));
      },
    ));

    return SpeedDial(
      icon: Icons.add,
      activeIcon: Icons.close,
      children: childButtons,
      spacing: 30.0,
      childMargin: const EdgeInsets.symmetric(horizontal: 4.0),
      childrenButtonSize: const Size(60, 60),
    );
  }
}
