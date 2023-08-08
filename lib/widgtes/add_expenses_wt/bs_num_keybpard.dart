import 'package:flutter/material.dart';
import 'package:gastos/models/combined_model.dart';
import 'package:gastos/utils/constants.dart';

class BSNumKeyboard extends StatefulWidget {
  final CombinedModel cModel;
  const BSNumKeyboard({super.key, required this.cModel});

  @override
  State<BSNumKeyboard> createState() => _BSNumKeyboardState();
}

class _BSNumKeyboardState extends State<BSNumKeyboard> {
  String import = '0.00';

  @override
  void initState() {
    import = widget.cModel.amount.toStringAsFixed(2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String Function(Match) mathFunc;
    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc = (Match match) => '${match[1]},';

    return GestureDetector(
      onTap: () {
        _numPad(context);
      },
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            const Text('Cantidad Ingresada'),
            Text(
              '€ ${import.replaceAllMapped(reg, mathFunc)}',
              style: const TextStyle(
                  fontSize: 30.0,
                  letterSpacing: 2.0,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  _numPad(BuildContext context) {
    if (import == '0.00') import = '';
    eexpenseChange(String amount) {
      if (amount == '') amount = '0.00';
      widget.cModel.amount = double.parse(amount);
    }

    num(String ttext, double hheight) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            import += ttext;
            widget.cModel.amount = double.parse(import);
          });
        },
        child: SizedBox(
          height: hheight,
          child: Center(
            child: Text(
              ttext,
              style: const TextStyle(fontSize: 35.0),
            ),
          ),
        ),
      );
    }

    showModalBottomSheet(
        isDismissible: false,
        enableDrag: false,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: SizedBox(
              height: 400.0,
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                var hheight = constraints.biggest.height / 5;
                return Column(
                  children: [
                    Table(
                      border: TableBorder.symmetric(
                          inside: const BorderSide(
                        color: Colors.grey,
                        width: 1.5,
                      )),
                      children: [
                        TableRow(children: [
                          num('1', hheight),
                          num('2', hheight),
                          num('3', hheight),
                        ]),
                        TableRow(children: [
                          num('4', hheight),
                          num('5', hheight),
                          num('6', hheight),
                        ]),
                        TableRow(children: [
                          num('7', hheight),
                          num('8', hheight),
                          num('9', hheight),
                        ]),
                        TableRow(children: [
                          num('.', hheight),
                          num('0', hheight),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              setState(() {
                                if (import.length > 0.0) {
                                  import =
                                      import.substring(0, import.length - 1);
                                  eexpenseChange(import);
                                }
                              });
                            },
                            onLongPress: () {
                              setState(() {
                                import = '';
                                eexpenseChange(import);
                              });
                            },
                            child: SizedBox(
                              height: hheight,
                              child: const Icon(
                                Icons.backspace,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ]),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            child: Constants.customButtom(
                                Colors.transparent, Colors.green, 'CANCELAR'),
                            onTap: () {
                              setState(() {
                                import = '0.00';
                                eexpenseChange(import);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            child: Constants.customButtom(
                                Colors.green, Colors.transparent, 'ACEPTAR'),
                            onTap: () {
                              setState(() {
                                if (import.length == 0.0) import = '0.20';
                                eexpenseChange(import);
                                Navigator.pop(context);
                              });
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                );
              }),
            ),
          );
        });
  }
}
