import 'package:flutter/material.dart';
import 'package:money_management/utils/constants.dart';

class ReusableCard extends StatelessWidget {
  final String name;
  final String ammount;
  final double height;
  final double? width;
  final TextStyle? style;

  final Function() onClick;
  const ReusableCard(
      {Key? key,
      required this.name,
      required this.ammount,
      required this.height,
      required this.onClick,
      this.style,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: kCardColor,
        elevation: 6,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: kCardColor, borderRadius: BorderRadius.circular(10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  name,
                  style: kCardTextStyle,
                ),
              ),
              kSizedBoxHeight,
              Center(
                child: Text(
                  ammount,
                  style: style,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
