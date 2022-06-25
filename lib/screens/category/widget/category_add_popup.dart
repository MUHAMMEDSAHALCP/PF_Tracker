import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:money_management/components/snackbar.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/utils/constants.dart';

Future<void> showCategoryAddPopUp(BuildContext context, _type) async {
  final _nameCategoryController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  showDialog(
    context: context,
    builder: (ctx) {
      return Form(
        key: _formKey,
        child: SimpleDialog(
          backgroundColor: kCardColor,
          title: const Text(
            "Add Category",
            style: kIntroTextStyle,
            textAlign: TextAlign.center,
          ),
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter category name!!!";
                  }
                  return (null);
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                ],
                controller: _nameCategoryController,
                decoration: const InputDecoration(
                  hintText: " Category name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () {
                  final newCategoryName = _nameCategoryController.text;
                  if (_formKey.currentState!.validate()) {
                    final _category = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: newCategoryName,
                      type: _type,
                    );

                    CategoryDB.instance.insertCategory(_category);
                    Navigator.pop(ctx);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kSecondoryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ))),
                child: const Text(
                  "ADD NEW CATEGORY",
                  style: kCardTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
