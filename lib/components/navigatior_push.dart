import 'package:flutter/material.dart';

nextPage({context, screen}) {
  Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 1600),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          animation = CurvedAnimation(
              parent: animation, curve: Curves.fastLinearToSlowEaseIn);
          return ScaleTransition(
              alignment: Alignment.center, scale: animation, child: child);
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return screen;
        },
      ));
}
