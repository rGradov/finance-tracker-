import 'package:flutter/material.dart';

class ScreenSize {
  final double screenHeight;
  final double screenWidth;
  static final ScreenSize _instance = ScreenSize._internal();

  factory ScreenSize() {
    return _instance;
  }

  /// SingleTone Factory
  ScreenSize._internal()
      : screenHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
          .size
          .height,
        screenWidth = MediaQueryData.fromWindow(WidgetsBinding.instance!.window)
            .size
            .width;
}