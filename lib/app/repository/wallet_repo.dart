import 'package:finance_tracker/app/model/models.dart';

class WalletRepository {
  var _wallet = const WalletModel('', WalletType.wallet, 0, CurrencyType.dollars);

  void setWalletName(String name) {
    _wallet = _wallet.copyWith(name: name);
  }

  void setWalletType(WalletType type) {
    _wallet = _wallet.copyWith(type: type);
  }

  void setCurrencyType(CurrencyType type) {
    _wallet = _wallet.copyWith(currencyType: type);
  }

  void setBalance(double balance) {
    _wallet = _wallet.copyWith(balance: balance);
  }
}
