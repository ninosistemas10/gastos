import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/models/entrie_model.dart';
import 'package:gastos/models/expenses_model.dart';
import 'package:gastos/models/feature_model.dart';
import 'package:gastos/provider/db_expenses.dart';
import 'package:gastos/provider/db_features.dart';

class ExpensesProvider extends ChangeNotifier {
  List<FeatureModel> fList = [];
  List<ExpensesModel> eList = [];
  List<CombinedModel> cList = [];
  List<EntriesModel> etList = [];

  /*   -----------  Funciones Grabar -----------   */

  addNewExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        expense: cModel.amount);

    final id = await DBExpenses.db.addExpense(expenses);
    expenses.id = id;
    eList.add(expenses);
    notifyListeners();
  }

  addNewFeature(String category, String color, String icon) async {
    final newFeature =
        FeatureModel(category: category, color: color, icon: icon);

    final id = await DBFeatures.db.addNewFeature(newFeature);
    newFeature.id = id;

    fList.add(newFeature);
    notifyListeners();
  }

  //addNewEntries ----------------------
  addNewEntries(CombinedModel cModel) async {
    var entries = EntriesModel(
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        entries: cModel.amount);

    final id = await DBExpenses.db.addEntries(entries);
    entries.id = id;
    etList.add(entries);
    notifyListeners();
  }

  //listar entries
  getEntriesByDate(int month, int year) async {
    final response = await DBExpenses.db.getEntriesByDate(month, year);
    etList = [...response];
    notifyListeners();
  }

  /*   -----------  Funciones Listar -----------   */

  getExpensesByDate(int month, int year) async {
    final response = await DBExpenses.db.getExpenseByDate(month, year);
    eList = [...response];
    notifyListeners();
  }

  getAllListeners() async {
    final response = await DBFeatures.db.getAllFeatures();
    fList = [...response];
    notifyListeners();
  }

  /*   -----------  Funciones Modificar -----------   */

  updateExpense(CombinedModel cModel) async {
    var expenses = ExpensesModel(
        id: cModel.id,
        link: cModel.link,
        year: cModel.year,
        month: cModel.month,
        day: cModel.day,
        comment: cModel.comment,
        expense: cModel.amount);
    await DBExpenses.db.updateExpenses(expenses);
  }

  updateFeature(FeatureModel features) async {
    await DBFeatures.db.updateFeatures(features);
    getAllListeners();
  }

/*   -----------  Funciones delete -----------   */

  deleteExpense(int id) async {
    await DBExpenses.db.deleteExpenses(id);
    notifyListeners();
  }

/*   ----------- Getters to combined List -----------   */

  List<CombinedModel> get allitemList {
    List<CombinedModel> ccModel = [];

    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          ccModel.add(CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              id: x.id,
              link: x.link,
              amount: x.expense,
              comment: x.comment,
              year: x.year,
              month: x.month,
              day: x.day));
        }
      }
    }
    return cList = [...ccModel];
  }

  List<CombinedModel> get groupItemList {
    List<CombinedModel> ccModel = [];

    for (var x in eList) {
      for (var y in fList) {
        if (x.link == y.id) {
          double aamount = eList
              .where((e) => e.link == y.id)
              .fold(0.0, (a, b) => a + b.expense);
          ccModel.add(CombinedModel(
              category: y.category,
              color: y.color,
              icon: y.icon,
              //id: x.id,
              amount: aamount
              //comment: x.comment,
              //year: x.year,
              //month: x.month,
              //day: x.day
              ));
        }
      }
    }
    var encode = ccModel.map((e) => jsonEncode(e));
    var unique = encode.toSet();
    var result = unique.map((e) => jsonDecode(e));
    ccModel = result.map((e) => CombinedModel.fromJson(e)).toList();
    return cList = [...ccModel];
  }
}
