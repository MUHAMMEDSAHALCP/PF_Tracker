// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:money_management/model/category/category_model.dart';
import 'package:money_management/model/transaction/transaction_model.dart';

// ignore: constant_identifier_names
const TRANSACTION_DB_NAME = "transactionDb";

abstract class CategoryDbFunction {
  Future<void> insertTransactions(TransactionModel value);
  Future<List<TransactionModel>> getTransactions();
  Future<void> deleteTransaction(String categoryID);
  Future<void> updateTransaction(String index, TransactionModel value);
  Future<void> resetTransactrion();
}

class TransactionDB implements CategoryDbFunction {
  TransactionDB._internal();
  static TransactionDB instance = TransactionDB._internal();
  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListener = ValueNotifier([]);
  ValueNotifier<double> incomeTotalBalanceListener = ValueNotifier(0);
  ValueNotifier<double> expenseTotalBalanceListener = ValueNotifier(0);
  ValueNotifier<double> totalBalanceListener = ValueNotifier(0);
  ValueNotifier<double> lendTotalBalanceListener = ValueNotifier(0);
  ValueNotifier<double> borrowTotalBalanceListener = ValueNotifier(0);

  ValueNotifier<List<TransactionModel>> incomeTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> expenseTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> lendTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> borrowTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> todayTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> monthlyTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> yesterdayTransactionListner =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> todayTransactionListnerIncomechart =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> yesterdayTransactionListnerIncomechart =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>> todayTransactionListnerExpensechart =
      ValueNotifier([]);
  ValueNotifier<List<TransactionModel>>
      yesterdayTransactionListnerExpensechart = ValueNotifier([]);

  @override
  Future<void> insertTransactions(TransactionModel value) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _transactionDB.put(value.id, value);
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _transactionDB.values.toList();
  }

  Future refreshUI() async {
    final allCategories = await getTransactions();
  
    allCategories.sort((first, second) => second.date.compareTo(first.date));
    todayTransactionListnerIncomechart.value.clear();
    yesterdayTransactionListnerIncomechart.value.clear();
    todayTransactionListnerExpensechart.value.clear();
    yesterdayTransactionListnerExpensechart.value.clear();
    transactionListener.value.clear();
    monthlyTransactionListner.value.clear();
    yesterdayTransactionListner.value.clear();
    todayTransactionListner.value.clear();
    incomeTransactionListner.value.clear();
    expenseTransactionListner.value.clear();
    lendTransactionListner.value.clear();
    borrowTransactionListner.value.clear();
    transactionListener.value.addAll(allCategories);
    totalBalanceListener.value = 0;
    incomeTotalBalanceListener.value = 0;
    expenseTotalBalanceListener.value = 0;
    lendTotalBalanceListener.value = 0;
    borrowTotalBalanceListener.value = 0;

    String todayDate = DateFormat.yMd().format(DateTime.now());
    String yesterdayDate = DateFormat.yMd()
        .format(DateTime.now().subtract(const Duration(days: 1)));
    String monthlyDate = DateFormat.yMd()
        .format(DateTime.now().subtract(const Duration(days: 30)));

    for (TransactionModel category in allCategories) {
      if (category.type == CategoryType.income) {
        incomeTransactionListner.value.add(category);
      } else if (category.type == CategoryType.expense) {
        expenseTransactionListner.value.add(category);
      } else if (category.type == CategoryType.lend) {
        lendTransactionListner.value.add(category);
      } else {
        borrowTransactionListner.value.add(category);
      }
    }
    await Future.forEach(
      allCategories,
      (TransactionModel category) {
        if (category.type == CategoryType.income) {
          incomeTotalBalanceListener.value =
              incomeTotalBalanceListener.value + category.amount;
        } else if (category.type == CategoryType.lend) {
          lendTotalBalanceListener.value =
              lendTotalBalanceListener.value + category.amount;
        } else if (category.type == CategoryType.borrow) {
          borrowTotalBalanceListener.value =
              borrowTotalBalanceListener.value + category.amount;
        } else {
          expenseTotalBalanceListener.value =
              expenseTotalBalanceListener.value + category.amount;
        }
        totalBalanceListener.value = incomeTotalBalanceListener.value -
            expenseTotalBalanceListener.value;
        String databaseDate = DateFormat.yMd().format(category.date);
        if (todayDate == databaseDate) {
          todayTransactionListner.value.add(category);
        }
        if (yesterdayDate == databaseDate) {
          yesterdayTransactionListner.value.add(category);
        }
        if (monthlyDate == databaseDate) {
          monthlyTransactionListner.value.add(category);
        }
        if (category.type == CategoryType.income) {
          if (todayDate == databaseDate) {
            todayTransactionListnerIncomechart.value.add(category);
          }
          if (yesterdayDate == databaseDate) {
            yesterdayTransactionListnerIncomechart.value.add(category);
          }
        }
        if (category.type == CategoryType.expense) {
          if (todayDate == databaseDate) {
            todayTransactionListnerExpensechart.value.add(category);
          }
          if (yesterdayDate == databaseDate) {
            yesterdayTransactionListnerExpensechart.value.add(category);
          }
        }
      },
    );

    // ignore: invalid_use_of_protected_member
    yesterdayTransactionListnerExpensechart.notifyListeners();
    // ignore: invalid_use_of_protected_member
    yesterdayTransactionListnerIncomechart.notifyListeners();
    // ignore: invalid_use_of_protected_member
    todayTransactionListnerIncomechart.notifyListeners();
    // ignore: invalid_use_of_protected_member
    todayTransactionListnerExpensechart.notifyListeners();
    // ignore: invalid_use_of_protected_member
    yesterdayTransactionListner.notifyListeners();
    // ignore: invalid_use_of_protected_member
    monthlyTransactionListner.notifyListeners();
    // ignore: invalid_use_of_protected_member
    todayTransactionListner.notifyListeners();
    // ignore: invalid_use_of_protected_member
    transactionListener.notifyListeners();
    // ignore: invalid_use_of_protected_member
    incomeTransactionListner.notifyListeners();
    // ignore: invalid_use_of_protected_member
    expenseTransactionListner.notifyListeners();
    // ignore: invalid_use_of_protected_member
    totalBalanceListener.notifyListeners();
    // ignore: invalid_use_of_protected_member
    incomeTotalBalanceListener.notifyListeners();
    // ignore: invalid_use_of_protected_member
    expenseTotalBalanceListener.notifyListeners();
  }

  @override
  Future<void> deleteTransaction(String categoryID) async {
    final _transactionDb =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    await _transactionDb.delete(categoryID);
    refreshUI();
  }

  @override
  Future<void> updateTransaction(String index, TransactionModel value) async {
    final _transactionDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _transactionDB.put(index, value);
    getTransactions();
  }

  @override
  Future<void> resetTransactrion() async {
    final _categoryDB =
        await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _categoryDB.clear();
    refreshUI();
  }
}
