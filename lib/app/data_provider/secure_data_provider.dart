import 'package:flutter_secure_storage/flutter_secure_storage.dart';
/// use if for secure data like pin code's user data and e.t.c
/// and basically use it for boarding
class SecureDataProvider {
  final FlutterSecureStorage _storage;

  SecureDataProvider() : _storage = const FlutterSecureStorage();

  Future<void> writeSecureData(
      {required String key, required String value}) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String?> readSecureData({required String key}) async {
    late String? _data;
    try {
      _data = await _storage.read(key: key);
    } catch (e) {
      throw Exception(e.toString());
    }
    return _data;
  }
}

/// [SecureKeys]
/// -- use pinCode keys for saving pinCode in secure storeage
/// -- use onBoarding keys to save bool value onBoarding is done true/false
abstract class SecureKeys {
  static const String pinCode = 'pinCode';
  static const String onBoarding = 'onBoarding';
}
