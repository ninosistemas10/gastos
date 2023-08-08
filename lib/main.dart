import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gastos/pages/add_expenses.dart';
import 'package:gastos/pages/categories_details.dart';
import 'package:gastos/pages/home_page.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:gastos/provider/ui_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ExpensesProvider()),
    ], child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      supportedLocales: const [Locale('en'), Locale('ES')],
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: ThemeData.dark().copyWith(
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              selectedItemColor: Colors.green),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.green[800],
              foregroundColor: Colors.white),
          colorScheme: const ColorScheme.dark(primary: Colors.green),
          dividerColor: Colors.grey,
          scaffoldBackgroundColor: Colors.grey[900],
          primaryColorDark: Colors.grey[850]),
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomePage(),
        'add_expenses': (_) => const AddExpenses(),
        'cat_details': (_) => const CategoriesDetails(),
      },
    );
  }
}
