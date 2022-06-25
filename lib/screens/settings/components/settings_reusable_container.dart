import 'package:flutter/material.dart';
import 'package:money_management/utils/constants.dart';

class ReusableSettingContainer extends StatelessWidget {
  final String title;
  final Function() onClick;
  final IconData icon;
  const ReusableSettingContainer(
      {Key? key,
      required this.title,
      required this.onClick,
      required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onClick,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height / 12,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: kCardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Icon(icon),
                  kSizedBoxWidth,
                  Text(
                    title,
                    style: const TextStyle(
                        fontFamily: "CrimsonText", fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
