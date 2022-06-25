import 'package:flutter/material.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/screens/overview/components/chartlogic.dart';
import 'package:money_management/screens/overview/widget/reusable_chart.dart';
import 'package:money_management/utils/constants.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  List<ChartData> data =
      chartLogic(TransactionDB.instance.incomeTransactionListner.value);
  List<ChartData> todayIncomeListGraph = chartLogic(
      TransactionDB.instance.todayTransactionListnerIncomechart.value);
  List<ChartData> yesterdayIncomeListGraph = chartLogic(
      TransactionDB.instance.yesterdayTransactionListnerIncomechart.value);

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
      "Today",
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
                  hint: Text(
                    _chosenValue ?? "All",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  dropdownColor: kCardColor,
                  isExpanded: true,
                  value: _chosenValue,
                  focusColor: Colors.black,
                  items: _items.map(buildMenuItem).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _chosenValue = newValue;
                    });
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
                          "No Income Data To Show Graph!!!",
                          style: kIntroTextStyle,
                        ),
                      )
                    : ReusableChart(
                        chartChecking: chartCheking(),
                        text: "Income OverView",
                      ))),
          ],
        ),
      ),
    );
  }

  List<ChartData> chartCheking() {
    if (_chosenValue == 'Today') {
      return todayIncomeListGraph;
    } else if (_chosenValue == 'Yesterday') {
      return yesterdayIncomeListGraph;
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
