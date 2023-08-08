import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';

class DatePicker extends StatefulWidget {
  final CombinedModel cModel;
  const DatePicker({super.key, required this.cModel});

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  String selecteDay = 'Hoy';

  @override
  void initState() {
    if (widget.cModel.day == 0) {
      widget.cModel.year = DateTime.now().year;
      widget.cModel.month = DateTime.now().month;
      widget.cModel.day = DateTime.now().day;
    } else {
      selecteDay = "Otro dia";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime ddate = DateTime.now();
    var wwidget = <Widget>[];

    wwidget.insert(0, const Icon(Icons.date_range_outlined, size: 35.0));
    wwidget.insert(1, const SizedBox(width: 5));

    ccalendar() {
      showDatePicker(
        context: context,
        locale: const Locale('es', 'ES'),
        initialDate: ddate.subtract(const Duration(hours: 24 * 2)),
        firstDate: ddate.subtract(const Duration(hours: 24 * 30)),
        lastDate: ddate.subtract(const Duration(hours: 24 * 2)),
      ).then((value) {
        setState(() {
          if (value != null) {
            widget.cModel.year = value.year;
            widget.cModel.month = value.month;
            widget.cModel.day = value.day;
          } else {
            setState(() {
              selecteDay = 'Hoy';
            });
          }
        });
      });
    }

    Map<String, DateTime> items = {
      'Hoy': ddate,
      'Ayer': ddate.subtract(const Duration(hours: 24)),
      'Otro dia': ddate
    };

    items.forEach((name, date) {
      wwidget.add(Expanded(
        child: GestureDetector(
          onTap: () {
            setState(() {
              selecteDay = name;
              widget.cModel.year = date.year;
              widget.cModel.month = date.month;
              widget.cModel.day = date.day;
              if (name == 'Otro dia') ccalendar();
            });
          },
          child: DateContainWidget(
            cModel: widget.cModel,
            name: name,
            isSelected: name == selecteDay,
          ),
        ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Row(children: wwidget),
    );
  }
}

class DateContainWidget extends StatelessWidget {
  final CombinedModel cModel;
  final String name;
  final bool isSelected;
  const DateContainWidget(
      {super.key,
      required this.cModel,
      required this.name,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: isSelected
                    ? Colors.green
                    : Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(25.0)),
            child: Center(child: Text(name)),
          ),
        ),
        isSelected
            ? FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('${cModel.day}/${cModel.month}/${cModel.year}'),
              )
            : const Text('')
      ],
    );
  }
}
