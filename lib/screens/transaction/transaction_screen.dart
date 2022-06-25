import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/transaction/components/see_more_screen.dart';
import 'package:money_management/screens/transaction/components/add_transaction_screen.dart';
import 'package:money_management/screens/transaction/components/full_borrow_details_screen.dart';
import 'package:money_management/screens/transaction/components/search_screen.dart';
import 'package:money_management/screens/transaction/components/widgets/reusable_card.dart';
import 'package:money_management/screens/transaction/components/widgets/reusablt_list_tile.dart';
import 'package:money_management/screens/transaction/components/full_expense_details_screen.dart';
import 'package:money_management/screens/transaction/components/full_income_details_screen.dart';
import 'package:money_management/screens/transaction/components/full_lend_details_screen.dart';
import 'package:money_management/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

String userNameNew = "";

class TransactionPage extends StatefulWidget {
  const TransactionPage({
    Key? key,
  }) : super(key: key);

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  void initState() {
    getUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUI();
    CategoryDB.instance.refreshUI();
    final _cardHeight = MediaQuery.of(context).size.height / 10;
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          CustomAppBar(
            title: "Hey $userNameNew",
            subtitle: 'Manage Your Finance Easily',
            // ignore: deprecated_member_use
            icon: const FaIcon(FontAwesomeIcons.search),
            onPress: () {
              showSearch(context: context, delegate: SearchScreen());
            },
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: TransactionDB.instance.totalBalanceListener,
                  builder: (BuildContext context, double value, Widget? child) {
                    return SizedBox(
                      child: ReusableCard(
                        name: 'TOTAL BALANCE',
                        style: const TextStyle(
                            fontSize: 18,
                            color: kSecondoryColor,
                            fontFamily: 'FiraSansCondensed'),
                        ammount: ' ₹ $value',
                        height: MediaQuery.of(context).size.height / 10,
                        onClick: () {},
                      ),
                    );
                  },
                ),
                kSizedBoxHeight,
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.incomeTotalBalanceListener,
                      builder:
                          (BuildContext context, incomeTotal, Widget? child) {
                        return Flexible(
                          child: ReusableCard(
                            name: 'Income',
                            ammount: '₹ $incomeTotal',
                            style: kCardAmountStyleGreen,
                            height: _cardHeight,
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FullIncomeList(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    kSizedBoxWidth,
                    ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.expenseTotalBalanceListener,
                      builder:
                          (BuildContext context, expenseTotal, Widget? child) {
                        return Flexible(
                          child: ReusableCard(
                            name: 'Expense',
                            ammount: '₹ $expenseTotal',
                            style: kCardAmountStyleRed,
                            height: _cardHeight,
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FullExpenseDetails(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                kSizedBoxHeight,
                Row(
                  children: [
                    ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.borrowTotalBalanceListener,
                      builder: (BuildContext context, double borrowTotal,
                          Widget? child) {
                        return Flexible(
                          child: ReusableCard(
                            name: 'Borrow',
                            ammount: '₹ $borrowTotal',
                            style: kCardAmountStyleRed,
                            height: _cardHeight,
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FullBorrowDetails(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                    kSizedBoxWidth,
                    ValueListenableBuilder(
                      valueListenable:
                          TransactionDB.instance.lendTotalBalanceListener,
                      builder:
                          (BuildContext context, lendTotal, Widget? child) {
                        return Flexible(
                          child: ReusableCard(
                            name: 'Lend',
                            ammount: '₹ $lendTotal',
                            style: kCardAmountStyleGreen,
                            height: _cardHeight,
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FullLendDetails(),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Recent transactions",
                        style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 17,
                            fontFamily: "CrimsonText"),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AllCategoryScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: const [
                                Text(
                                  "See more",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "CrimsonText"),
                                ),
                                Icon(Icons.arrow_right)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          kSizedBoxHeight,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 5,
              ),
              child: ValueListenableBuilder(
                valueListenable: TransactionDB.instance.transactionListener,
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
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 5,
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
                          itemCount: (newListVlues.length <= 5)
                              ? newListVlues.length
                              : 5);
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 8,
        backgroundColor: kSecondoryColor,
        onPressed: () {
          Navigator.pushNamed(context, AddTransactionScreen.routeName);
        },
        child: const Icon(Icons.add),
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  getUserName() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    final userName = sharedPreferences.getString("keyValue");
    setState(() {
      userNameNew = userName!;
    });
  }
}
