import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureDataProvider {
  final FlutterSecureStorage _storage;
  SecureDataProvider():_storage = const FlutterSecureStorage();


  Future<void> writeSecureData({required String key,required String value})async{
  await _storage.write(key: key, value: value);
  }

  Future<String?> readSecureData({required String key})async{
    final _data = await _storage.read(key: key);
    if(_data !=null){
      return _data;
    }
  }

}
abstract class SecureKeys {
  static const String pinCode = 'pinCode';
}