import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuthRepository {
  final LocalAuthentication _auth;

  LocalAuthRepository() : _auth = LocalAuthentication();
  bool _isProtectionEnabled = false;

  bool get isProtectionEnabled => _isProtectionEnabled;

  set isProtectionEnabled(bool enabled) => _isProtectionEnabled = enabled;
  bool _isAuthenticated = false;

  bool get isAuthenticated => _isAuthenticated;

  Future<bool> auth() async {
    if (!_isProtectionEnabled) {
      try {
        _isAuthenticated = await _auth.authenticate(
          localizedReason: 'authenticate to access',
          stickyAuth: true,
        );
      } on PlatformException catch (e) {
        debugPrint(e.toString());
      }
    }
    return _isAuthenticated;
  }
}
