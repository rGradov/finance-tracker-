import 'package:finance_tracker/app/repository/wallet_repo.dart';
import 'package:flutter/foundation.dart';

class AddedNewWalletViewModel with ChangeNotifier {
  final WalletRepository _repository = WalletRepository();
  final AddedNewWalletVMState _state = AddedNewWalletVMState(false);

  bool get continueButtonIsVisible => _state.continueButtonStatus;
}

class AddedNewWalletVMState {
  final bool continueButtonStatus;

  AddedNewWalletVMState(this.continueButtonStatus);
}
