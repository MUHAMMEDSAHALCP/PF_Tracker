import 'package:flutter/material.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/screens/overview/components/chartlogic.dart';
import 'package:money_management/screens/overview/widget/reusable_chart.dart';
import 'package:money_management/utils/constants.dart';

class ExpenseScreen extends StatefulWidget {
  const ExpenseScreen({Key? key}) : super(key: key);

  @override
  State<ExpenseScreen> createState() => _ExpenseScreenState();
}

class _ExpenseScreenState extends State<ExpenseScreen> {
  List<ChartData> data =
      chartLogic(TransactionDB.instance.expenseTransactionListner.value);
  List<ChartData> todayExpenseListGraph = chartLogic(
      TransactionDB.instance.todayTransactionListnerExpensechart.value);
  List<ChartData> yesterdayExpenseListGraph = chartLogic(
      TransactionDB.instance.yesterdayTransactionListnerExpensechart.value);

  String? _chosenValue;

  @override
  void initState() {
    TransactionDB.instance.refreshUI();
    CategoryDB.instance.refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _items = [
      "All",
      'Today',
      'Yesterday',
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            kSizedBoxHeight,
            kSizedBoxHeight,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height / 16,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: kSecondoryColor)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: const Text(
                    "All",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  dropdownColor: kCardColor,
                  isExpanded: true,
                  value: _chosenValue,
                  focusColor: Colors.black,
                  items: _items.map(buildMenuItem).toList(),
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
            kSizedBoxHeight,
            kSizedBoxHeight,
            Expanded(
                child: (data.isEmpty
                    ? const Center(
                        child: Text(
                          "No Expense Data To Show Graph!!!",
                          style: kIntroTextStyle,
                        ),
                      )
                    : ReusableChart(
                        chartChecking: chartCheking(),
                        text: 'Expense OverView',
                      ))),
          ],
        ),
      ),
    );
  }

  List<ChartData> chartCheking() {
    if (_chosenValue == 'Today') {
      return todayExpenseListGraph;
    } else if (_chosenValue == 'Yesterday') {
      return yesterdayExpenseListGraph;
    } else {
      return data;
    }
  }
}

DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
