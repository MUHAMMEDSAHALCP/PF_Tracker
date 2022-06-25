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
import 'package:money_management/screens/home/home_screen.dart';
import 'package:money_management/screens/intro_screen/widget/profile_name_screen.dart';
import 'package:money_management/utils/constants.dart';

// ignore: must_be_immutable
class EditingScreen extends StatefulWidget {
  TransactionModel transaactionDatas;

  EditingScreen({required this.transaactionDatas, Key? key}) : super(key: key);

  @override
  State<EditingScreen> createState() => _EditingScreenState();
}

class _EditingScreenState extends State<EditingScreen> {
  CategoryModel? _selectedCategoryModel;
  CategoryType? _selectedCategoryType;
  DateTime? _seletedDate;
  String? _categotyID;

  @override
  void initState() {
    super.initState();

    _selectedCategoryType = widget.transaactionDatas.type;
    _seletedDate = widget.transaactionDatas.date;
    _amountController.text = widget.transaactionDatas.amount.toString();
    _notesController.text = widget.transaactionDatas.notes;
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width / 6.6;
    final _height = MediaQuery.of(context).size.height / 20;

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Edit Your Transacton",
            subtitle: "Now You Can Edit Your Transaction",
            // ignore: deprecated_member_use
            icon: const FaIcon(FontAwesomeIcons.home),
            onPress: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, HomeScreen.routeName, (route) => false);
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
                        height: _height,
                        width: _width,
                        child: const Center(
                          child: Text(
                            "Income",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kWhite),
                          ),
                        ),
                      ),
                      selected: _selectedCategoryType == CategoryType.income
                          ? true
                          : false,
                      selectedColor: kGreenColor,
                      onSelected: (value) {
                        setState(
                          () {
                            _selectedCategoryType = CategoryType.income;
                            _categotyID = null;
                          },
                        );
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: kSecondoryColor,
                      label: SizedBox(
                        height: _height,
                        width: _width,
                        child: const Center(
                          child: Text(
                            "Expense",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kWhite),
                          ),
                        ),
                      ),
                      selected: _selectedCategoryType == CategoryType.expense
                          ? true
                          : false,
                      selectedColor: kRedColor,
                      onSelected: (value) {
                        setState(
                          () {
                            _selectedCategoryType = CategoryType.expense;
                            _categotyID = null;
                          },
                        );
                      },
                    ),
                    ChoiceChip(
                      backgroundColor: kSecondoryColor,
                      label: SizedBox(
                        height: _height,
                        width: _width,
                        child: const Center(
                          child: Text(
                            "Lend",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: kWhite),
                          ),
                        ),
                      ),
                      selected: _selectedCategoryType == CategoryType.lend
                          ? true
                          : false,
                      selectedColor: kGreenColor,
                      onSelected: (value) {
                        if (value) {
                          setState(
                            () {
                              _selectedCategoryType = CategoryType.lend;
                            },
                          );
                        }
                      },
                    ),
                    ChoiceChip(
                        backgroundColor: kSecondoryColor,
                        label: SizedBox(
                          height: _height,
                          width: _width,
                          child: const Center(
                            child: Text(
                              "Borrow",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, color: kWhite),
                            ),
                          ),
                        ),
                        selected: _selectedCategoryType == CategoryType.borrow
                            ? true
                            : false,
                        selectedColor: kRedColor,
                        onSelected: (value) {
                          setState(
                            () {
                              _selectedCategoryType = CategoryType.borrow;
                            },
                          );
                        }),
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
                      const EdgeInsets.only(left: 25, right: 25, bottom: 10),
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
                                const Text("Category :  ",
                                    style: kTextFieldTextStyle),
                                Expanded(
                                    child: Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          17.5),
                                  child: Row(
                                    children: [
                                      Center(
                                          child: DropdownButton(
                                              value: _categotyID,
                                              hint: const AutoSizeText(
                                                  "Select Category"),
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
                                              onChanged:
                                                  (String? selectedValue) {
                                                setState(() {
                                                  _categotyID = selectedValue;
                                                });
                                              })),
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
                                  ),
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
                              const Text("Amount   : ",
                                  style: kTextFieldTextStyle),
                              kSizedBoxWidth,
                              kSizedBoxWidth,
                              Expanded(
                                child: TextFormField(
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
                              const Text("Notes         : ",
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
                          updateTransaction();
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

  Future<void> updateTransaction() async {
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
      } else {
        final _model = TransactionModel(
            date: _seletedDate!,
            type: _selectedCategoryType!,
            amount: _parsedAmount,
            notes: _notes,
            category: _selectedCategoryModel,
            id: widget.transaactionDatas.id);
        await TransactionDB.instance
            .updateTransaction(widget.transaactionDatas.id!, _model);
        TransactionDB.instance.refreshUI();
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
        showScnakBar(context, "Updated Successfully!!!");
      }
    } else {
      if (_amount.isEmpty ||
          _seletedDate == null ||
          _parsedAmount == null ||
          _notes.isEmpty) {
        return showScnakBar(context, "Please Fill your field completely!!!");
      } else {
        final _model = TransactionModel(
            date: _seletedDate!,
            type: _selectedCategoryType!,
            amount: _parsedAmount,
            notes: _notes,
            category: _selectedCategoryModel,
            id: widget.transaactionDatas.id);
        await TransactionDB.instance
            .updateTransaction(widget.transaactionDatas.id!, _model);
        TransactionDB.instance.refreshUI();

        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);

        showScnakBar(context, "Updated Successfully!!!");
      }
    }
  }
}
