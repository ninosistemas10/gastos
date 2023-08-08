import 'package:flutter/material.dart';

class PageAnimationRoute extends PageRouteBuilder {
  final Widget widget;
  final double ejeX;
  final double ejeY;

  PageAnimationRoute(
      {required this.widget, required this.ejeX, required this.ejeY})
      : super(
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secAnimation,
                Widget child) {
              animation =
                  CurvedAnimation(parent: animation, curve: Curves.easeOutBack);
              return ScaleTransition(
                alignment: Alignment(ejeX, ejeY),
                scale: animation,
                child: child,
              );
            },
            pageBuilder: (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secAnimation,
            ) {
              return widget;
            });
}
