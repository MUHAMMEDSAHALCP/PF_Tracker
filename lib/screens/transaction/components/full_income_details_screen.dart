import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/transaction/components/widgets/reusablt_list_tile.dart';
import 'package:money_management/utils/constants.dart';

class FullIncomeList extends StatelessWidget {
  static const routeName = "Income Details";
  const FullIncomeList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refreshUI();

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: "Income Transactions",
            subtitle: "See All Your Income Transactions",
            icon: const FaIcon(
              // ignore: deprecated_member_use
              FontAwesomeIcons.home,
              color: kblack,
            ),
            onPress: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ValueListenableBuilder(
                valueListenable:
                    TransactionDB.instance.incomeTransactionListner,
                builder: (BuildContext context,
                    List<TransactionModel> newListVlues, Widget? _) {
                  return newListVlues.isEmpty
                      ? const Center(
                          child: Text(
                            "No Income Transactions Yet!!!",
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
}
