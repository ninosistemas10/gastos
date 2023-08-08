import 'package:flutter/material.dart';
import 'package:gastos/provider/expenses_provider.dart';
import 'package:provider/provider.dart';

class EntriesDetails extends StatefulWidget {
  const EntriesDetails({super.key});

  @override
  State<EntriesDetails> createState() => _EntriesDetailsState();
}

class _EntriesDetailsState extends State<EntriesDetails> {
  @override
  Widget build(BuildContext context) {
    final eetList = context.watch<ExpensesProvider>().etList;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Desglose de Ingresos'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate((context, i) {
            return ListTile(
              title: Text(eetList[i].entries.toString()),
            );
          }, childCount: eetList.length))
        ],
      ),
    );
  }
}
