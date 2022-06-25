import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/components/delete_popup.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/transaction/components/editing_screen.dart';
import 'package:money_management/screens/transaction/components/widgets/full_transaction_details.dart';
import 'package:money_management/utils/constants.dart';

class ReusableListTile extends StatelessWidget {
  final TransactionModel newList;
  const ReusableListTile({
    Key? key,
    required this.newList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(key: Key(newList.id!)),
        children: [
          SlidableAction(
            foregroundColor: kGreenColor,
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EditingScreen(transaactionDatas: newList),
                ),
              );
            },
            icon: Icons.edit,
            label: "Edit",
          ),
          SlidableAction(
            foregroundColor: kRedColor,
            onPressed: (context) {
              showDeletePopUp(context, transactionId: newList.id);
            },
            icon: Icons.delete,
            label: "Delete",
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        color: kListColor,
        child: Container(
          height: MediaQuery.of(context).size.height / 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kListColor,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FullTransactonDetails(
                            datas: newList,
                          )));
            },
            child: Center(
              child: ListTile(
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 30,
                      width: 80,
                      decoration: BoxDecoration(
                        color: newList.type == CategoryType.income ||
                                newList.type == CategoryType.lend
                            ? kGreenColor
                            : kRedColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          parsedWeek(newList.date),
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: "Cinzel",
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      parseDate(newList.date),
                      style: const TextStyle(
                          fontFamily: "FiraSansCondensed", fontSize: 14),
                    )
                  ],
                ),
                title: Text(
                  newList.category != null
                      ? newList.category!.name
                      : newList.type == CategoryType.borrow
                          ? 'Borrow'
                          : newList.type == CategoryType.lend
                              ? "Lend"
                              : "",
                  style: kIntroTextStyle,
                  textAlign: TextAlign.center,
                ),
                subtitle: Text(
                    newList.notes.length > 10 ? " see more..." : newList.notes,
                    textAlign: TextAlign.center),
                trailing: Text(
                  "₹ ${newList.amount}",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'FiraSansCondensed',
                    color: newList.type == CategoryType.income
                        ? kGreenColor
                        : kRedColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final splittedDate = _date.split(' ');
    return '${splittedDate.last} ${splittedDate.first}';
  }

  String parsedWeek(DateTime date) {
    return DateFormat.EEEE().format(date);
  }
}
