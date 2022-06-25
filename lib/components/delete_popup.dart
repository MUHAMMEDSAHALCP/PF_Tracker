// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/utils/constants.dart';

Future<void> showDeletePopUp(BuildContext context,
    {categoryId, transactionId}) async {
  final _selectedId = categoryId;
  // ignore:
  final _selectedID = transactionId;

  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        backgroundColor: kCardColor,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Do you want to delete?",
                style: kIntroTextStyle,
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
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      if (transactionId == null) {
                        CategoryDB.instance.deleteCategory(categoryId);
                      } else {
                        TransactionDB.instance.deleteTransaction(transactionId);
                      }
                      Navigator.pop(ctx);
                    },
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                          color: kRedColor,
                          fontFamily: "Cinzel",
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
