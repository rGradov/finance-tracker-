import 'package:finance_tracker/app/repository/user_code_repo.dart';
import 'package:flutter/material.dart';

class PinCodeViewModel with ChangeNotifier {
  final UserRepo _userRepo = UserRepo();
  PinCodeVmState _state = PinCodeVmState(0);

  PinCodeVmState get state => _state;

  bool get isValid => _state.pinCircles < 4 ? false : true;
  bool get existCircles => _state.pinCircles <= 0 ? false : true;
  int get numberOfCircles =>_state.pinCircles;

  void onRemoveButtonPressed() {
    _userRepo.decrementPin();
    _state = PinCodeVmState(_userRepo.user.pinCode.length);
    notifyListeners();
  }

  void onNumberButtonPressed(int num) {
    _userRepo.incrementPin(num);
    _state = PinCodeVmState(_userRepo.user.pinCode.length);
    notifyListeners();
  }
}

class PinCodeVmState {
  final int pinCircles;

  PinCodeVmState(this.pinCircles);
}
