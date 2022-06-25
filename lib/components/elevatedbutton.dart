import 'package:flutter/material.dart';
import 'package:money_management/utils/constants.dart';

class ReusableElevatedButton extends StatelessWidget {
  final Function() onClick;
  final String buttonName;

  const ReusableElevatedButton(
      {Key? key, required this.onClick, required this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(kSecondoryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 3.5,
              vertical: 12,
            ),
            child: Text(
              buttonName,
              style: const TextStyle(
                  fontFamily: 'CrimsonText',
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
