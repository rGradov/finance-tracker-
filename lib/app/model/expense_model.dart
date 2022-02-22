import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/utils/app_lattachment_link.dart';

/// This is the main type for Expense  basically [ExpenseType.income]
/// have "+"and Green color and [ExpenseType.expenses]  have red color
/// and "-"
enum ExpenseType {
  income,
  expenses,
  transfer,

}
/// its just for now, what need to made we can easily switch
/// between global Currency
enum CurrencyType {
  dollars,
  rubles,
  byn,
  euro,
}
/// we use category enum for switching between icons and for better filters
enum Category {
  shopping,
  subscription,
  food,
  habit,
  hobby,
  salary,
  transport,
  unknown,
}

class Expense extends Equatable {
  final String name;
  final DateTime creationDate;
  final ExpenseType type;
  final String walletId;
  final double? value;
  final CurrencyType currency;
  final String? description;
  final DateTime? editDate;
  final List<AttachmentsLink>? attachments;
  final Category category;

  const Expense(
      {this.currency = CurrencyType.dollars,
      required this.type,
      required this.name,
      this.value,
      this.attachments,
      required this.category,
      required this.creationDate,
      this.description,
      this.editDate,
      required this.walletId});

  @override
  List<Object?> get props => [
        name,
        creationDate,
        type,
        walletId,
        value,
        currency,
        description,
        editDate,
        attachments,
        category,
      ];
}
