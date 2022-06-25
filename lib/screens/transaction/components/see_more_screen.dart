import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/transaction/components/widgets/reusablt_list_tile.dart';
import 'package:money_management/utils/constants.dart';
import 'package:month_year_picker/month_year_picker.dart';

class AllCategoryScreen extends StatefulWidget {
  static const routeName = "all-categories";
  const AllCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

ValueNotifier<bool> visibleMonth = ValueNotifier(false);
DateTime selectedMonth = DateTime.now();
DateTime selectedDate = DateTime.now();

String? _chosenValue = 'All';
final _period = [
  'All',
  'Today',
  'Monthly',
  'Yesterday',
];

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  void initState() {
    updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          CustomAppBar(
            title: "Transactions",
            subtitle: "See All Your Transactions",
            // ignore: deprecated_member_use
            icon: const FaIcon(FontAwesomeIcons.home),
            onPress: () {
              Navigator.pop(context);
            },
          ),
          kSizedBoxHeight,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: kSecondoryColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  _chosenValue.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),
                dropdownColor: kCardColor,
                isExpanded: true,
                value: _chosenValue,
                focusColor: Colors.black,
                items: _period.map(buildMenuItem).toList(),
                onChanged: (newValue) {
                  setState(
                    () {
                      _chosenValue = newValue;
                    },
                  );
                },
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: visibleMonth,
            builder: (context, bool value, Widget? _) {
              return Visibility(
                visible: value,
                child: TextButton(
                  onPressed: () {
                    pickDate(context);
                  },
                  child: Text(DateFormat("MMMM").format(selectedMonth)),
                ),
              );
            },
          ),
          kSizedBoxHeight6,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ValueListenableBuilder(
                valueListenable: valueChecking(context),
                builder: (BuildContext context,
                    List<TransactionModel> newListVlues, Widget? _) {
                  return newListVlues.isEmpty
                      ? const Center(
                          child: Text(
                            "No Transactions Yet!!!",
                            style: kIntroTextStyle,
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 15,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final newList = newListVlues[index];
                            return ReusableListTile(
                              newList: newList,
                            );
                          },
                          separatorBuilder: (context, index) {
                            return kSizedBoxHeight6;
                          },
                          itemCount: newListVlues.length);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      );
  ValueListenable<List<TransactionModel>> valueChecking(context) {
    visibleMonth.value = false;
    if (_chosenValue == 'Today') {
      return TransactionDB.instance.todayTransactionListner;
    } else if (_chosenValue == 'Monthly') {
      visibleMonth.value = true;
      return TransactionDB.instance.monthlyTransactionListner;
    } else if (_chosenValue == 'Yesterday') {
      return TransactionDB.instance.yesterdayTransactionListner;
    } else {
      return TransactionDB.instance.transactionListener;
    }
  }

  pickDate(context) async {
    final selected = await showMonthYearPicker(
      context: context,
      firstDate: DateTime(2020),
      initialDate: selectedMonth,
      lastDate: selectedDate,
    );
    setState(() {
      selectedMonth = selected ?? DateTime.now();
    });
    TransactionDB.instance.monthlyTransactionListner.value.clear();
    updateData();
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    TransactionDB.instance.monthlyTransactionListner.notifyListeners();
  }
}

updateData() async {
  Future.forEach(TransactionDB.instance.transactionListener.value,
      (TransactionModel model) {
    if (model.date.month == selectedMonth.month &&
        model.date.year == selectedMonth.year) {
      TransactionDB.instance.monthlyTransactionListner.value.add(model);
    }
  });
}

String parseDate(DateTime date) {
  final _date = DateFormat.MMMd().format(date);
  final splittedDate = _date.split(' ');
  return '${splittedDate.last} ${splittedDate.first}';
}

String parsedWeek(DateTime date) {
  return DateFormat.EEEE().format(date);
}
