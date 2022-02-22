part of 'account_balance_bloc.dart';

abstract class AccountBalanceState extends Equatable {
  const AccountBalanceState();
}

/// loading account balance form sql data base
class AccountBalanceLoading extends AccountBalanceState {
  const AccountBalanceLoading();

  @override
  List<Object?> get props => [];
}

/// disputed empty value for account balance
class AccountBalanceEmpty extends AccountBalanceState {
  const AccountBalanceEmpty({required this.currency});

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
class AccountBalanceLoaded extends AccountBalanceState {
  const AccountBalanceLoaded({required this.currency, required this.value});

  /// displayed current currency
  final CurrencyType currency;
  final double value;

  /// use if for show account balance
  String get accountBalance => value.toString() + currency.toString();

  @override
  List<Object?> get props => [currency, value];
}
