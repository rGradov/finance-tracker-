part of 'expenses_bloc.dart';

abstract class ExpensesState extends Equatable {
  const ExpensesState();
}

/// loading expense income form sql data base
class ExpensesLoading extends ExpensesState {
  const ExpensesLoading();

  @override
  List<Object?> get props => [];
}

/// disputed empty value for account balance
class ExpensesEmpty extends ExpensesState {
  const ExpensesEmpty({required this.currency});

  /// displayed current currency
  final CurrencyType currency;

  /// use if for show account balance
  String get accountBalance => 0.0.toString() + currency.toString();

  @override
  List<Object?> get props => [
    currency,
  ];
}
/// when account balance was loaded
class ExpensesLoaded extends ExpensesState {
  const ExpensesLoaded({required this.currency, required this.value});

  /// displayed current currency
  final CurrencyType currency;
  final double value;

  /// use if for show account balance
  String get accountBalance => value.toString() + currency.toString();

  @override
  List<Object?> get props => [currency, value];
}