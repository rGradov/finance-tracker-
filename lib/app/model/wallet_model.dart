import 'package:equatable/equatable.dart';
/// basic types for wallet
enum WalletType {
  bank,
  card,
  wallet, // <-- not sure about it
}

/// this is a basic types for currency in app
enum CurrencyType {
  dollar,
  ruble,
  bellRuble,
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
