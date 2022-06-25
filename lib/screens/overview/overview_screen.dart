import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/utils/constants.dart';
import 'package:money_management/screens/overview/components/expance_screen.dart';
import 'package:money_management/screens/overview/components/income_screen.dart';

class OverViewScreen extends StatefulWidget {
  const OverViewScreen({Key? key}) : super(key: key);

  @override
  State<OverViewScreen> createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  late VoidCallback onChanged;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    onChanged = () {
      setState(() {
        _currentIndex = _tabController.index;
      });
    };
    _tabController.addListener(onChanged);
  }

  @override
  void dispose() {
    _tabController.removeListener(onChanged);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
              title: "OverView",
              subtitle: "Your Transaction statitics",
              icon: FaIcon(
                FontAwesomeIcons.a,
                color: kPrimaryColor,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              children: [
                kSizedBoxHeight,
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kCardColor,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      unselectedLabelColor: Colors.black,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: _currentIndex == 0 ? kGreenColor : kRedColor,
                      ),
                      tabs: const [
                        Tab(
                          text: "Income",
                        ),
                        Tab(
                          text: "Expense",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                IncomeScreen(),
                ExpenseScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
