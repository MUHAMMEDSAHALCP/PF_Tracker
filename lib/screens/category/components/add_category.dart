import 'package:flutter/material.dart';
import 'package:money_management/utils/constants.dart';

class AddCategory extends StatelessWidget {
  final Function() onClick;
  final String name;
  final IconData icon;
  const AddCategory({
    Key? key,
    required this.onClick,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: GestureDetector(
        onTap: onClick,
        child: Column(
          children: [
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  color: kSecondoryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          color: kWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "CrimsonText"),
                    ),
                    IconButton(
                      onPressed: onClick,
                      icon: Icon(
                        icon,
                        color: kWhite,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
