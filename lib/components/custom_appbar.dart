import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_management/utils/constants.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final FaIcon icon;
  final Function()? onPress;
  const CustomAppBar({
    Key? key,
    required this.title,
    required this.subtitle,
    this.onPress,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
        child: ListTile(
            title: Text(
              title,
              style: kIntroTextStyle,
            ),
            subtitle: Text(subtitle),
            trailing: IconButton(
              iconSize: 20,
              onPressed: onPress,
              icon: icon,
              color: kblack,
            )),
      ),
    );
  }
}
