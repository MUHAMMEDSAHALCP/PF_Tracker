import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:money_management/components/custom_appbar.dart';
import 'package:money_management/components/navigatior_push.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/transaction/components/editing_screen.dart';
import 'package:money_management/screens/transaction/components/widgets/reusable_details_container.dart';
import 'package:money_management/utils/constants.dart';

// ignore: must_be_immutable
class FullTransactonDetails extends StatelessWidget {
  TransactionModel datas;

  FullTransactonDetails({
    Key? key,
    required this.datas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: Column(
        children: [
          CustomAppBar(
            title: "Transaction Details",
            subtitle: 'Now You Can See All Your Details.',
            onPress: () {
              nextPage(
                  context: context,
                  screen: EditingScreen(
                    transaactionDatas: datas,
                  ));
            },
            // ignore: deprecated_member_use
            icon: const FaIcon(FontAwesomeIcons.edit),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 22, bottom: 10),
              child: Container(
                decoration: kTextFieldBoxDecoration,
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage("assets/list.png"),
                    ),
                    ReusableDeatailsContainer(
                      textKey: "Category :",
                      textValue: datas.category != null
                          ? datas.category!.name.toUpperCase()
                          : datas.type == CategoryType.borrow
                              ? 'Borrow'
                              : datas.type == CategoryType.lend
                                  ? "Lend"
                                  : "",
                    ),
                    ReusableDeatailsContainer(
                        textKey: "Date           :",
                        textValue: parseDate(datas.date)),
                    ReusableDeatailsContainer(
                        textKey: "Amount   :",
                        textValue: datas.amount.toString()),
                    ReusableDeatailsContainer(
                      textKey: "Notes         :",
                      textValue:
                          datas.notes.isEmpty ? "No notes yet!!!" : datas.notes,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

String parseDate(DateTime date) {
  return DateFormat.yMMMMEEEEd().format(date);
}
