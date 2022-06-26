import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:money_management/components/delete_popup.dart';
import 'package:money_management/data_base/category/category_db.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/screens/category/components/add_category.dart';
import 'package:money_management/screens/category/widget/category_add_popup.dart';
import 'package:money_management/utils/constants.dart';

class ExpanseCategotyScreen extends StatefulWidget {
  const ExpanseCategotyScreen({Key? key}) : super(key: key);

  @override
  State<ExpanseCategotyScreen> createState() => _ExpanseCategotyScreenState();
}

class _ExpanseCategotyScreenState extends State<ExpanseCategotyScreen> {
  final _type = CategoryType.expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          AddCategory(
            name: 'Add Category',
            onClick: () {
              showCategoryAddPopUp(
                context,
                _type,
              );
            },
            icon: Icons.add,
          ),
          kSizedBoxHeight,
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: CategoryDB.instance.expenseCategoryListLListener,
              builder: (BuildContext context, List<CategoryModel> newList,
                  Widget? _) {
                return newList.isEmpty
                    ? const Center(
                        child: Text(
                          "No Categories Yet!!!",
                          style: kIntroTextStyle,
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: newList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 6),
                        ),
                        itemBuilder: (context, index) {
                          final category = newList[index];
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: StretchMotion(
                                key: Key(category.id),
                              ),
                              children: [
                                SlidableAction(
                                  foregroundColor: kRedColor,
                                  onPressed: (context) {
                                    showDeletePopUp(context,
                                        categoryId: category.id);
                                  },
                                  icon: Icons.delete,
                                  label: "Delete",
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              color: kListColor,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: kListColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    category.name,
                                    style: kCardTextStyle,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

showScnakBar(BuildContext context, name) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kSecondoryColor,
      content: Text(
        ' $name Deleted!!! ',
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
