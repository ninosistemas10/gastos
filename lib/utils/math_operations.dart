import 'package:intl/intl.dart';

import '../models/entrie_model.dart';
import '../models/expenses_model.dart';

export 'package:gastos/utils/math_operations.dart';

getAmountformat(double amount) {
  return NumberFormat.simpleCurrency().format(amount);
}

getSumOfExPenses(List<ExpensesModel> eList) {
  double eeList;
  eeList = eList.map((e) => e.expense).fold(0.0, (a, b) => a + b);
  return eeList;
}

getSumOfEntries(List<EntriesModel> etList) {
  double eetList;
  eetList = etList.map((e) => e.entries).fold(0.0, (a, b) => a + b);
  return eetList;
}

getBalance(List<ExpensesModel> eList, List<EntriesModel> etList) {
  double balance;

  balance = getSumOfEntries(etList) - getSumOfExPenses(eList);
  return getAmountformat(balance);
}
