import 'package:flutter/material.dart';
import 'package:gastos/provider/ui_provider.dart';
import 'package:provider/provider.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = context.read<UIProvider>();
    int currentPage = context.watch<UIProvider>().selectedMonth;

    PageController ccontroller;

    ccontroller =
        PageController(initialPage: currentPage, viewportFraction: 0.4);

    return SizedBox(
      height: 40.0,
      child: PageView(
        onPageChanged: (int i) => uiProvider.selectedMonth = i,
        controller: ccontroller,
        children: [
          _pageitems('Enero', 0, currentPage),
          _pageitems('Febrero', 1, currentPage),
          _pageitems('Marzo', 2, currentPage),
          _pageitems('Abril', 3, currentPage),
          _pageitems('Mayo', 4, currentPage),
          _pageitems('Junio', 5, currentPage),
          _pageitems('Julio', 6, currentPage),
          _pageitems('Agosto', 7, currentPage),
          _pageitems('Septiembre', 8, currentPage),
          _pageitems('Octubre', 9, currentPage),
          _pageitems('Noviembre', 10, currentPage),
          _pageitems('Diciembre', 11, currentPage),
        ],
      ),
    );
  }

  _pageitems(String name, int position, int currentPage) {
    var aalignment = Alignment.center;

    const selected = TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold);
    final unSelected = TextStyle(fontSize: 16.0, color: Colors.grey[700]);
    if (position == currentPage) {
      aalignment = Alignment.center;
    } else if (position > currentPage) {
      aalignment = Alignment.centerRight / 2;
    } else {
      aalignment = Alignment.centerLeft / 2;
    }

    return Align(
      alignment: aalignment,
      child: Text(
        name,
        style: position == currentPage ? selected : unSelected,
      ),
    );
  }
}
