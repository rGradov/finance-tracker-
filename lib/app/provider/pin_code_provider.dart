import 'package:flutter/material.dart';

class PinCodeProvider with ChangeNotifier {
  String _pinCode = '';
  String get getPinCode => _pinCode;
  bool get isValid => _pinCode.length < 4 ? false : true;
  void removeValue() {
    if (_pinCode.isNotEmpty) {
      _pinCode = _pinCode.substring(0, _pinCode.length - 1);
      notifyListeners();
    }
  }

  void setValue(int num) {
    if (_pinCode.length <= 4) {
      _pinCode = _pinCode + num.toString();
      notifyListeners();
    }
  }
}
