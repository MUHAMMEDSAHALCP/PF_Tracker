// import 'package:flutter/material.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:money_management/data_base/transaction/transction.db.dart';
// import 'package:money_management/model/transaction/transaction_model.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       // Remove the debug banner
//       debugShowCheckedModeBanner: false,
//       title: 'Kindacode.com',
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // This holds a list of fiction users
//   // You can use data fetched from a database or a server as well
//   Future<List<TransactionModel>> getTransactions() async {
//     final _transactionDB =
//         await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
//     return _transactionDB.values.toList();
//   }

//   Future allCategories() async {
//        final  _allCategoriesList  = await getTransactions();
//   }

//   // This list holds the data for the list view
//   List<Map<String, dynamic>> _foundUsers = [];
//   @override
//   initState() {
//     // at the beginning, all users are shown
//     _foundUsers = getTransactions() as List<Map<String, dynamic>>;
//     super.initState();
//   }

//   // This function is called whenever the text field changes
//   void _runFilter(String enteredKeyword) {
//     List<Map<String, dynamic>> results = [];
//     if (enteredKeyword.isEmpty) {
//       // if the search field is empty or only contains white-space, we'll display all users
//       results = _allUsers;
//     } else {
//       results = _allUsers
//           .where(
//             (user) => user["name"].toLowerCase().contains(
//                   enteredKeyword.toLowerCase(),
//                 ),
//           )
//           .toList();
//       // we use the toLowerCase() method to make it case-insensitive
//     }

//     // Refresh the UI
//     setState(() {
//       _foundUsers = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kindacode.com'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(10),
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 20,
//             ),
//             TextField(
//               onChanged: (value) => _runFilter(value),
//               decoration: const InputDecoration(
//                   labelText: 'Search', suffixIcon: Icon(Icons.search)),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Expanded(
//               child: _foundUsers.isNotEmpty
//                   ? ListView.builder(
//                       itemCount: _foundUsers.length,
//                       itemBuilder: (context, index) => Card(
//                         key: ValueKey(_foundUsers[index]["id"]),
//                         color: Colors.amberAccent,
//                         elevation: 4,
//                         margin: const EdgeInsets.symmetric(vertical: 10),
//                         child: ListTile(
//                           leading: Text(
//                             _foundUsers[index]["id"].toString(),
//                             style: const TextStyle(fontSize: 24),
//                           ),
//                           title: Text(_foundUsers[index]['name']),
//                           subtitle: Text(
//                               '${_foundUsers[index]["age"].toString()} years old'),
//                         ),
//                       ),
//                     )
//                   : const Text(
//                       'No results found',
//                       style: TextStyle(fontSize: 24),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_management/components/delete_popup.dart';
import 'package:money_management/data_base/transaction/transction.db.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/model/transaction/transaction_model.dart';
import 'package:money_management/screens/transaction/components/editing_screen.dart';
import 'package:money_management/screens/transaction/components/widgets/full_transaction_details.dart';
import 'package:money_management/utils/constants.dart';

class SearchScreen extends SearchDelegate {
  SearchScreen({
    String hintText = "search by day Or month",
  }) : super(
          searchFieldLabel: hintText,
          searchFieldStyle: const TextStyle(
            fontFamily: "Cinzel",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  Widget? get automaticallyImplyLeading => null;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: query.isEmpty
            // ignore: deprecated_member_use
            ? const Text("")
            : const Icon(Icons.close),
        color: kSecondoryColor,
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    kSizedBoxHeight;
    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListener,
        builder: (BuildContext context, List<TransactionModel> categoriesList,
            Widget? child) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final newList = categoriesList[index];
                if (parsedWeek(newList.date).toUpperCase().contains(query) ||
                    parsedWeek(newList.date).toLowerCase().contains(query) ||
                    parseDate(newList.date).toUpperCase().contains(query) ||
                    parseDate(newList.date).toLowerCase().contains(query)) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Slidable(
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
                              showDeletePopUp(context,
                                  transactionId: newList.id);
                            },
                            icon: Icons.delete,
                            label: "Delete",
                          ),
                        ],
                      ),
                      child: Card(
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
                                      builder: (context) =>
                                          FullTransactonDetails(
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
                                        color:
                                            // ignore: unrelated_type_equality_checks
                                            newList.type ==
                                                        CategoryType.income ||
                                                    newList.type ==
                                                        CategoryType.lend
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
                                    Text(parseDate(newList.date), style: kBold)
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
                                    newList.notes.length > 10
                                        ? "see more..."
                                        : newList.notes,
                                    textAlign: TextAlign.center),
                                trailing: Text(
                                  "₹ ${newList.amount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    // ignore: unrelated_type_equality_checks
                                    color: newList.type == CategoryType.income
                                        ? kGreenColor
                                        : kRedColor,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FullTransactonDetails(
                                                  datas: newList)));
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const Text("");
                }
              },
              itemCount: categoriesList.length);
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    kSizedBoxHeight;

    return ValueListenableBuilder(
        valueListenable: TransactionDB.instance.transactionListener,
        builder: (BuildContext context, List<TransactionModel> categoriesList,
            Widget? child) {
          return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final newList = categoriesList[index];
                if (parsedWeek(newList.date).toUpperCase().contains(query) ||
                    parsedWeek(newList.date).toLowerCase().contains(query) ||
                    parseDate(newList.date).toUpperCase().contains(query) ||
                    parseDate(newList.date).toLowerCase().contains(query)) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Slidable(
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
                              showDeletePopUp(context,
                                  transactionId: newList.id);
                            },
                            icon: Icons.delete,
                            label: "Delete",
                          ),
                        ],
                      ),
                      child: Card(
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
                                      builder: (context) =>
                                          FullTransactonDetails(
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
                                        color:
                                            // ignore: unrelated_type_equality_checks
                                            newList.type ==
                                                        CategoryType.income ||
                                                    newList.type ==
                                                        CategoryType.lend
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
                                    Text(parseDate(newList.date), style: kBold)
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
                                    newList.notes.length > 10
                                        ? "see more..."
                                        : newList.notes,
                                    textAlign: TextAlign.center),
                                trailing: Text(
                                  "₹ ${newList.amount}",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    // ignore: unrelated_type_equality_checks
                                    color: newList.type == CategoryType.income
                                        ? kGreenColor
                                        : kRedColor,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FullTransactonDetails(
                                                  datas: newList)));
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              },
              itemCount: categoriesList.length);
        });
  }
}

String parseDate(DateTime date) {
  final _date = DateFormat.MMMd().format(date);
  final splittedDate = _date.split(' ');
  return '${splittedDate.last} ${splittedDate.first}';
}

String parsedWeek(DateTime date) {
  return DateFormat.EEEE().format(date);
}
