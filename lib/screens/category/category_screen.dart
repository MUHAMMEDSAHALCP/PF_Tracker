import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/utils/constants.dart';
import 'package:money_management/screens/category/expanse_category_screen.dart';
import 'package:money_management/screens/category/income_categry_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentIndex = 0;
  late VoidCallback onPressed;

  @override
  void initState() {
    CategoryDB().refreshUI();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    onPressed = () => setState(() {
          _currentIndex = _tabController.index;
        });
    _tabController.addListener(onPressed);
  }

  @override
  void dispose() {
    _tabController.removeListener(onPressed);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          const CustomAppBar(
              title: "Category",
              subtitle: "See All your Categories",
              icon: FaIcon(
                FontAwesomeIcons.a,
                color: kPrimaryColor,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              children: [
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
                      unselectedLabelColor: kblack,
                      indicator: BoxDecoration(
                          color: _currentIndex == 0 ? kGreenColor : kRedColor,
                          borderRadius: BorderRadius.circular(10)),
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
                )
              ],
            ),
          ),
          Expanded(
            child: SizedBox(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  IncomCategoryScreen(),
                  ExpanseCategotyScreen(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
