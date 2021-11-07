import 'package:flutter/material.dart';
import 'package:finance_tracker/app/ui/screens/pin_screen.dart';
import 'package:finance_tracker/app/ui/screens/setup_account_screen.dart';


abstract class AppRoutes {
  static const mainRoute = '/';
  static const setupAccountRoute = '/setup';

}
class MainNavigation {
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
    AppRoutes.mainRoute:(_)=>const PinScreen(),
    AppRoutes.setupAccountRoute:(_)=>const SetupAccountScreen(),
  };


  Route<dynamic>? onGenerateRoute(RouteSettings settings){
    return null;
  }
  
  
}