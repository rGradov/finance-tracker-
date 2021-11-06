import 'package:flutter/material.dart';

class PinCodeProvider with ChangeNotifier {
  String _pinCode = '';
  String get getPinCode => _pinCode;
  bool get isValid => _pinCode.length < 4 ? false : true;
  void setValue(int num) {
    if (_pinCode.length <= 4) {
      _pinCode = _pinCode + num.toString();
      notifyListeners();
    }
  }
}
