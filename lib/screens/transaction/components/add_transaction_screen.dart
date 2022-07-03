import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/components/elevatedbutton.dart';
import 'package:money_management/components/snackbar.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/category/widget/category_add_popup.dart';
import 'package:money_management/screens/intro_screen/widget/profile_name_screen.dart';
import 'package:money_management/utils/constants.dart';

class AddTransactionScreen extends StatefulWidget {
  static const routeName = "add-transaction";
  const AddTransactionScreen({Key? key}) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  CategoryModel? _selectedCategoryModel;
  CategoryType? _selectedCategoryType;
  DateTime? _seletedDate;
  String? _categotyID;
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();

  String type = "Income";

  @override
  void initState() {
    super.initState();
    _seletedDate = DateTime.now();
    _selectedCategoryType = CategoryType.income;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Add Transaction",
            subtitle: "Now you can add your transaction",
            // ignore: deprecated_member_use
            icon: const FaIcon(FontAwesomeIcons.home),
            onPress: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ChoiceChip(
                      backgroundColor: kSecondoryColor,
                      label: SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 6.6,
                        child: const Center(
                          child: AutoSizeText(
                            "Income",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: kWhite,
                                fontFamily: "CrimsonText"),
                          ),
                        ),
                      ),
                      selected: type == "Income" ? true : false,
                      selectedColor: kGreenColor,
                      onSelected: (value) {
                        setState(
                          () {
                            type = "Income";
                            _selectedCategoryType = CategoryType.income;
                            _categotyID = null;
                          },
                        );
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: kSecondoryColor,
                      label: SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 6.6,
                        child: const Center(
                          child: AutoSizeText(
                            "expense",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kWhite),
                          ),
                        ),
                      ),
                      selected: type == "expense" ? true : false,
                      selectedColor: kRedColor,
                      onSelected: (value) {
                        setState(
                          () {
                            type = "expense";
                            _selectedCategoryType = CategoryType.expense;
                            _categotyID = null;
                          },
                        );
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: kSecondoryColor,
                      label: SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 6.6,
                        child: const Center(
                          child: AutoSizeText(
                            "Lend",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kWhite),
                          ),
                        ),
                      ),
                      selected: type == "Lend" ? true : false,
                      selectedColor: kGreenColor,
                      onSelected: (value) {
                        if (value) {
                          setState(
                            () {
                              type = "Lend";
                              _selectedCategoryType = CategoryType.lend;
                              _categotyID = null;
                            },
                          );
                        }
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: kSecondoryColor,
                      label: SizedBox(
                        height: MediaQuery.of(context).size.height / 20,
                        width: MediaQuery.of(context).size.width / 6.6,
                        child: const Center(
                          child: AutoSizeText(
                            "Borrow",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kWhite),
                          ),
                        ),
                      ),
                      selected: type == "Borrow" ? true : false,
                      selectedColor: kRedColor,
                      onSelected: (value) {
                        setState(
                          () {
                            type = "Borrow";
                            _selectedCategoryType = CategoryType.borrow;
                            _categotyID = null;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                  child: Column(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kListColor,
                        child: Container(
                          padding: kTextFieldPadding,
                          decoration: kTextFieldBoxDecoration,
                          child: Row(
                            children: [
                              const Text(
                                "Date          :",
                                style: kTextFieldTextStyle,
                              ),
                              Expanded(
                                child: TextButton.icon(
                                  onPressed: () async {
                                    final _selectedDateTemp =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now().subtract(
                                        const Duration(days: 30),
                                      ),
                                      lastDate: DateTime.now(),
                                    );

                                    if (_selectedDateTemp == null) {
                                      return;
                                    } else {
                                      setState(() {});
                                      _seletedDate = _selectedDateTemp;
                                    }
                                  },
                                  icon:
                                      const Icon(Icons.calendar_today_rounded),
                                  label: Text(
                                    DateFormat.MMMMEEEEd()
                                        .format(_seletedDate!),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _selectedCategoryType == CategoryType.income ||
                              _selectedCategoryType == CategoryType.expense
                          ? kSizedBoxHeight6
                          : const SizedBox(),
                      Visibility(
                        visible:
                            (_selectedCategoryType == CategoryType.borrow ||
                                    _selectedCategoryType == CategoryType.lend)
                                ? false
                                : true,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          color: kListColor,
                          child: Container(
                              padding: kTextFieldPadding,
                              decoration: kTextFieldBoxDecoration,
                              child: Row(children: [
                                const AutoSizeText("Category :  ",
                                    style: kTextFieldTextStyle),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: DropdownButton(
                                          value: _categotyID,
                                          hint: const Text("Select Category"),
                                          items: (_selectedCategoryType ==
                                                      CategoryType.income
                                                  ? CategoryDB
                                                      .instance
                                                      .incomeCategoryListListener
                                                      .value
                                                  : CategoryDB
                                                      .instance
                                                      .expenseCategoryListLListener
                                                      .value)
                                              .map((e) {
                                            return DropdownMenuItem(
                                              child: AutoSizeText(e.name),
                                              value: e.id,
                                              onTap: () {
                                                _selectedCategoryModel = e;
                                              },
                                            );
                                          }).toList(),
                                          onChanged: (String? selectedValue) {
                                            setState(() {
                                              _categotyID = selectedValue;
                                            });
                                          }),
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          showCategoryAddPopUp(
                                              context, _selectedCategoryType);
                                        },
                                        child: const Icon(
                                          Icons.add,
                                          color: kSecondoryColor,
                                        )),
                                  ],
                                ))
                              ])),
                        ),
                      ),
                      kSizedBoxHeight6,
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kListColor,
                        child: Container(
                          padding: kTextFieldPadding,
                          decoration: kTextFieldBoxDecoration,
                          child: Row(
                            children: [
                              const Text("Amount   :",
                                  style: kTextFieldTextStyle),
                              kSizedBoxWidth,
                              kSizedBoxWidth,
                              Expanded(
                                child: TextFormField(
                                  keyboardAppearance: Brightness.dark,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  keyboardType: TextInputType.number,
                                  controller: _amountController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter Amount",
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kSizedBoxHeight6,
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: kListColor,
                        child: Container(
                          padding: kTextFieldPadding,
                          decoration: kTextFieldBoxDecoration,
                          child: Row(
                            children: [
                              const Text("Notes         :",
                                  style: kTextFieldTextStyle),
                              kSizedBoxWidth,
                              kSizedBoxWidth,
                              Expanded(
                                child: TextFormField(
                                  maxLines: 4,
                                  minLines: 1,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(50),
                                  ],
                                  controller: _notesController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Write Something...!",
                                    focusedBorder: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      kSizedBox,
                      ReusableElevatedButton(
                        onClick: () {
                          addTransaction();
                        },
                        buttonName: 'Submit',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addTransaction() async {
    final _notes = _notesController.text;
    final _amount = _amountController.text;
    final _parsedAmount = double.tryParse(_amount);

    if (_selectedCategoryType == CategoryType.income ||
        _selectedCategoryType == CategoryType.expense) {
      if (_amount.isEmpty ||
          _seletedDate == null ||
          _parsedAmount == null ||
          _selectedCategoryModel == null) {
        return showScnakBar(context, "Please Fill your field completely!!!");
      }
      if (_amount == "0") {
        showScnakBar(context, "Enter correct amount!!!");
      } else {
        final _model1 = TransactionModel(
            date: _seletedDate!,
            type: _selectedCategoryType!,
            category: _selectedCategoryModel,
            amount: _parsedAmount,
            notes: _notes,
            id: DateTime.now().microsecondsSinceEpoch.toString());
        TransactionDB.instance.insertTransactions(_model1);
        Navigator.pop(context);
        showScnakBar(context, "Transaction Added Successfully");

        TransactionDB.instance.refreshUI();
      }
    } else {
      if (_amount.isEmpty ||
          _seletedDate == null ||
          _parsedAmount == null ||
          _notes.isEmpty) {
        return showScnakBar(context, "Please Fill your field completely!!!");
      }
      if (_amount == "0") {
        showScnakBar(context, "Enter correct amount!!!");
      } else {
        final _model2 = TransactionModel(
          date: _seletedDate!,
          amount: _parsedAmount,
          type: _selectedCategoryType!,
          notes: _notes,
          id: DateTime.now().microsecondsSinceEpoch.toString(),
        );
        TransactionDB.instance.insertTransactions(_model2);
        Navigator.pop(context);
        showScnakBar(context, "Transaction Added Successfully!!!");
        TransactionDB.instance.refreshUI();
      }
    }
  }
}
