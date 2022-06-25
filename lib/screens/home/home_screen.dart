import 'package:flutter/material.dart';
import 'package:money_management/screens/transaction/transaction_screen.dart';
import 'package:money_management/utils/constants.dart';
import 'package:money_management/screens/category/category_screen.dart';
import 'package:money_management/screens/overview/overview_screen.dart';
import 'package:money_management/screens/settings/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "main screen ";

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int _currentPageIndex = 0;
final _pages = [
  const TransactionPage(),
  const OverViewScreen(),
  const CategoryScreen(),
  const SettingScreen()
];

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _currentPageIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: kPrimaryColor,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          currentIndex: _currentPageIndex,
          onTap: (newIndex) {
            setState(() {});
            _currentPageIndex = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_rounded,
                size: 28,
              ),
              label: "Transaction",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.track_changes,
                size: 28,
              ),
              label: "Overview",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.category_rounded,
                size: 28,
              ),
              label: "Categories",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 28,
              ),
              label: "Settings",
            ),
          ],
        ),
      ),
    );
  }
}
