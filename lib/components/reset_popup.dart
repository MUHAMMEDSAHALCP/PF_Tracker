import 'package:flutter/material.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/screens/intro_screen/splash_screen.dart';
import 'package:money_management/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> showResetPopUp(
  BuildContext context,
) async {
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        contentPadding: const EdgeInsets.all(10),
        title: const Text(
          "Are You Sure?",
          textAlign: TextAlign.center,
          style: kCardTextStyle,
        ),
        backgroundColor: kCardColor,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [ 
              const Text(
                "Do you want to Reset your Data?",
                style: TextStyle(
                  fontFamily: "CrimsonText",
                  fontSize: 18,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text(
                      "No",
                      style: TextStyle(
                          color: kGreenColor,
                          fontFamily: "Cinzel",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      CategoryDB.instance.resetCategory();
                      TransactionDB.instance.resetTransactrion();
                      final sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.clear();
                      Navigator.pushAndRemoveUntil(
                          ctx,
                          MaterialPageRoute(
                              builder: (context) => const SplashScreen()),
                          (route) => false);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                          fontSize: 18,
                          color: kRedColor,
                          fontFamily: "CrimsonText",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      );
    },
  );
}
