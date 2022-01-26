import 'package:finance_tracker/app/data_provider/secure_data_provider.dart';
import 'package:finance_tracker/app/model/user_model.dart';

class UserRepo {
  final SecureDataProvider _secureDataProvider;
  var _user = UserModel('');

  UserRepo() : _secureDataProvider = SecureDataProvider();

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
}
