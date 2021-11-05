import 'package:flutter/material.dart';

abstract class AppTheme {
  static final ThemeData light = ThemeData(
    primarySwatch: Colors.blue,
  );
}
abstract class AppColor {
  static const MaterialColor violet =
  MaterialColor(_primary, <int, Color>{
    50: Color(0xFFE6FFFF),
    100: Color(0xFF7F3DFF),
    200: Color(0xFF94E9FF),
    300: Color(0xFF6ACDFF),
    400: Color(0xFF4CBAFF),
    500: Color(0xFF05A5FF),
    600: Color(0xFF0095EB),
    700: Color(0xFF0080D1),
    800: Color(0xFF006BB7),
    900: Color(0xFF00559B),
  });
  static const MaterialColor baseLight = MaterialColor(_base, <int,Color>{
    80:Color(0xFFFCFCFC),

});
  static const int _base = 0xFF00000;
  static const int _primary = 0xFF05A5FF;
}