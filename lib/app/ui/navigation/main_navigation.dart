import 'package:flutter/material.dart';

import '../app_auth.dart';

abstract class Screens {
  static const main = '/';

}
class MainNavigation {
  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
    Screens.main:(_)=>const PinScreen()};


  Route<dynamic>? onGenerateRoute(RouteSettings settings){
    return null;
  }
  
  
}