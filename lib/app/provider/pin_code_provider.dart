import 'package:flutter/material.dart';

class PinCodeProvider with ChangeNotifier {
  String pin = '';
  String get getPin => pin;
  bool get isValid => pin.length < 4 ? false : true;
  void removeValue() {
    if (pin.isNotEmpty) {
      pin = pin.substring(0, pin.length - 1);
      notifyListeners();
    }
  }

  void setValue(int num) {
    if (pin.length <= 3) {
      pin = pin + num.toString();
      notifyListeners();
    }
  }
}
