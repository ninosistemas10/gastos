import 'package:flutter/cupertino.dart';

class UIProvider extends ChangeNotifier {
  int _bnbIndex = 0;
  int get bnbIndex => _bnbIndex;

  int _selectedMonth = DateTime.now().month - 1;

  set bnbIndex(int i) {
    _bnbIndex = i;
    notifyListeners();
  }

  int get selectedMonth => _selectedMonth;
  set selectedMonth(int i) {
    _selectedMonth = i;
    print(_selectedMonth);
    notifyListeners();
  }
}
