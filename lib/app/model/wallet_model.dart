import 'package:equatable/equatable.dart';

import 'package:finance_tracker/app/model/expense_model.dart' show CurrencyType;
/// basic types for wallet
enum WalletType {
  bank,
  card,
  wallet, // <-- not sure about it
}


class WalletModel extends Equatable {
  final String name;
  final WalletType type;
  final double balance;
  final CurrencyType currencyType;

  const WalletModel(this.name, this.type, this.balance, this.currencyType);
  WalletModel copyWith({
    String? name,
    WalletType? type,
    double? balance,
    CurrencyType? currencyType,
  }) {
    return WalletModel(name ?? this.name, type ?? this.type,
        balance ?? this.balance, currencyType ?? this.currencyType);
  }

  @override
  List<Object?> get props => [name,type,balance,currencyType];
}
