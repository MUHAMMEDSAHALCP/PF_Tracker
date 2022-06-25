import 'package:flutter/material.dart';
import 'package:money_management/utils/constants.dart';

showScnakBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      duration: const Duration(seconds: 2),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: kPrimaryColor,
      content: Text(
        text,
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
