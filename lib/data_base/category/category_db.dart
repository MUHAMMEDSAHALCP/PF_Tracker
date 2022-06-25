// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member, duplicate_ignore

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:money_management/model/category/category_model.dart';

// ignore: constant_identifier_names
const CATEGORY_DB_NAME = "categoryDb";

abstract class CategoryDbFunction {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertCategory(CategoryModel value);
  Future<void> deleteCategory(String categoryId);
  Future<void> resetCategory();
}

class CategoryDB implements CategoryDbFunction {
  CategoryDB._internal();

  static CategoryDB instance = CategoryDB._internal();
  factory CategoryDB() {
    return instance;
  }

  final ValueNotifier<List<CategoryModel>> incomeCategoryListListener =
      ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> expenseCategoryListLListener =
      ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> lendCategoryListLListener =
      ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> borrowCategoryListLListener =
      ValueNotifier([]);
  @override
  Future<void> insertCategory(CategoryModel value) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.put(value.id, value);
    refreshUI();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    return _categoryDB.values.toList();
  }

  Future refreshUI() async {
    final allCategories = await getCategories();
    incomeCategoryListListener.value.clear();
    expenseCategoryListLListener.value.clear();
  
    Future.forEach(
      allCategories,
      (CategoryModel category) {
        if (category.type == CategoryType.income) {
          incomeCategoryListListener.value.add(category);
        } else if (category.type == CategoryType.lend) {
          lendCategoryListLListener.value.add(category);
        } else if (category.type == CategoryType.income) {
          borrowCategoryListLListener.value.add(category);
        } else {
          expenseCategoryListLListener.value.add(category);
        }
      },
    );
    // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
    incomeCategoryListListener.notifyListeners();
    expenseCategoryListLListener.notifyListeners();
  }

  @override
  Future<void> deleteCategory(String categoryId) async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    await _categoryDB.delete(categoryId);
    refreshUI();
  }

  @override
  Future<void> resetCategory() async {
    final _categoryDB = await Hive.openBox<CategoryModel>(CATEGORY_DB_NAME);
    _categoryDB.clear();
    refreshUI();
  }
}
