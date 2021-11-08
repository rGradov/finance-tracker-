import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/screens/pin_screen.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final MainNavigation mainNavigation = MainNavigation();
   MyApp({Key? key}): super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:AppTheme.light,
      onGenerateRoute:mainNavigation.onGenerateRoute,
      home: const PinScreen(),
    );
  }
}