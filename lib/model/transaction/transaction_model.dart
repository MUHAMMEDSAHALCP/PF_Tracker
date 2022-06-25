import 'package:hive_flutter/adapters.dart';
import 'package:money_management/model/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class TransactionModel {
  @HiveField(0)
  String? id;
  @HiveField(1)
  final DateTime date;
  @HiveField(2)
  final CategoryType type;
  @HiveField(3)
  final double amount;
  @HiveField(4)
  final String notes;
  @HiveField(5)
  final CategoryModel? category;

  TransactionModel({
    required this.date,
    required this.type,
    required this.amount,
    required this.notes,
    this.category,
    required this.id,
  });
}
