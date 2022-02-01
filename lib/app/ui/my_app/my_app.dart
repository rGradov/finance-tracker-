import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/navigation/navigation_service.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/app/ui/view/auth/onboarding/onboarding_screen.dart';
import 'package:finance_tracker/app/ui/view/auth/sign_up_screen.dart';
import 'package:finance_tracker/app/ui/view/pin_screen.dart';
import 'package:finance_tracker/main.dart';
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
      navigatorKey: getIt<NavigationService>().mainNavigation,
      home:  const OnBoardingScreen(),
    );
  }
}