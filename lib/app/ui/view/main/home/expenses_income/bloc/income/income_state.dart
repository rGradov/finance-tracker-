part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();
}

/// loading expense income form sql data base
class IncomeLoading extends IncomeState {
  const IncomeLoading();

  @override
  List<Object?> get props => [];
}

/// disputed empty value for account balance
class IncomeEmpty extends IncomeState {
  const IncomeEmpty({required this.currency});

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
class IncomeLoaded extends IncomeState {
  const IncomeLoaded({required this.currency, required this.value});

  /// displayed current currency
  final CurrencyType currency;
  final double value;

  /// use if for show account balance
  String get accountBalance => value.toString() + currency.toString();

  @override
  List<Object?> get props => [currency, value];
}