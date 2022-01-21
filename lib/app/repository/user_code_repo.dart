import 'package:finance_tracker/app/model/user_model.dart';

class UserRepo {
  var _user = UserModel('');

  UserModel get user => _user;
  String get pin =>_user.pinCode;
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
}
