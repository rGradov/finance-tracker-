import 'package:animations/animations.dart';
import 'package:finance_tracker/app/ui/screens/added_new_account.dart';
import 'package:flutter/material.dart';
import 'package:finance_tracker/app/ui/screens/pin_screen.dart';
import 'package:finance_tracker/app/ui/screens/setup_account_screen.dart';


abstract class AppRoutes {
  static const mainRoute = '/';
  static const setupAccountRoute = '/setup';
  static const addedNewAccount = '/setup/add';

}
class MainNavigation {
  final AppRouteUtils _routeUtils = AppRouteUtils();
  Map<String, WidgetBuilder> get routes =>
      <String, WidgetBuilder>{
        AppRoutes.mainRoute: (_) => const PinScreen(),
        AppRoutes.setupAccountRoute: (_) => const SetupAccountScreen(),
        AppRoutes.addedNewAccount: (_) => const AddedNewAccountScreen(),
      };


  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case AppRoutes.mainRoute:
        return _routeUtils.sharedAxisTransition(
            screen: const AddedNewAccountScreen(),
            settings: settings);
      case AppRoutes.setupAccountRoute:
        return _routeUtils.sharedAxisTransition(
            screen: const  SetupAccountScreen(),
            settings: settings);
      case AppRoutes.addedNewAccount:
        return _routeUtils.sharedAxisTransition(
            screen: const  AddedNewAccountScreen(),
            settings: settings);

    }
  }
}


class AppRouteUtils {
  PageRouteBuilder<dynamic> sharedAxisTransition(
      {required Widget screen, required RouteSettings settings}) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,) =>
      screen,
      transitionsBuilder: (BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
          Widget child,) =>
          SharedAxisTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            transitionType: SharedAxisTransitionType.horizontal,
            child: child,
          ),
    );
  }
}