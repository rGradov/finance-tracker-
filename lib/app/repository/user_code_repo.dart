import 'package:finance_tracker/analytics/analytics_repository.dart';
import 'package:finance_tracker/app/data_provider/secure_data_provider.dart';
import 'package:finance_tracker/app/model/user_model.dart';
import 'package:flutter/material.dart';
enum FieldStatus {
  valid,
  inValid,
  empty,
}

class UserRepo {
  final SecureDataProvider _secureDataProvider;
  var _user = const UserModel('','','');
  UserRepo() : _secureDataProvider = SecureDataProvider();
  static final RegExp _emailReg = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  static final RegExp _passwordReg = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  UserModel get user => _user;

  String get pin => _user.pinCode;

  /// load password
  Future<String?> loadPin()async {
   final _data = await _secureDataProvider.readSecureData(key: SecureKeys.pinCode);
    return _data;
  }
  Future<void> savePin(String pin)async{
    await _secureDataProvider.writeSecureData(key: SecureKeys.pinCode, value: pin);
  }

  void decrementPin() {
    if (_user.pinCode.isNotEmpty) {
      _user = _user.copyWith(
          pinCode: _user.pinCode.substring(0, _user.pinCode.length - 1));
    }
  }


  void incrementPin(int num) {
    if (_user.pinCode.length <= 3) {
      _user = _user.copyWith(pinCode: _user.pinCode + num.toString());
    }
  }
  void pastePin(String pin){
    _user = _user.copyWith(pinCode: pin);
  }
  FieldStatus updateEmail(String email){
    if(_emailReg.hasMatch(email)){
      debugPrint('email is valid');
      _user = _user.copyWith(email: email);
      return FieldStatus.valid;
    }else {
      debugPrint('email is in valid');
      return FieldStatus.inValid;

    }
  }

  FieldStatus updatePassword(String password){
    if(_passwordReg.hasMatch(password)){
      _user = _user.copyWith(password: password);
      debugPrint('password is valid');
      return FieldStatus.valid;
    }else {
      debugPrint('password is invalid');
      return FieldStatus.inValid;
    }
  }
  FieldStatus checkPassword(String password){
    if(password == _user.password){
      debugPrint('rePassword == password');
      return FieldStatus.valid;
    }else {
      debugPrint('rePassword != password');

      return FieldStatus.inValid;
    }
  }

}
