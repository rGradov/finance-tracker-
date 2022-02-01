import 'package:finance_tracker/app/ui/navigation/main_navigation.dart';
import 'package:finance_tracker/app/ui/view/auth/auth_screen.dart';
import 'package:finance_tracker/app/ui/view/auth/sign_up_screen.dart';
import 'package:finance_tracker/app/ui/view/auth/verification/verification_screen.dart';
import 'package:flutter/material.dart';

abstract class AuthRouteNames{
  static const String verificationRoute = 'verification';
  static const String loginRoute = 'login';
  static const String initialRoute = 'signUp';

}
class AuthNavigation {
  final AppRouteUtils _routeUtils = AppRouteUtils();

  Map<String, WidgetBuilder> get routes =>
      <String, WidgetBuilder>{
        AuthRouteNames.loginRoute: (_) => const LoginScreen(),
        AuthRouteNames.initialRoute: (_) => const SignUpScreen(),
        AuthRouteNames.verificationRoute: (_) => const VerificationScreen(),
      };
  Route<dynamic>? onGenerateRoute(RouteSettings settings) {

    switch(settings.name){
      case AuthRouteNames.loginRoute:
        return _routeUtils.sharedAxisTransition(
            screen: const LoginScreen(),
            settings: settings);
      case AuthRouteNames.initialRoute:
        return _routeUtils.sharedAxisTransition(
            screen: const  SignUpScreen(),
            settings: settings);
      case AuthRouteNames.verificationRoute:
        return _routeUtils.sharedAxisTransition(
            screen: const  VerificationScreen(),
            settings: settings);
    }
  }
}

class NestedNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> navigationKey;
  final String initialRoute;
  final Route<dynamic>?   Function(RouteSettings)? onGenerateRoute;
  final Map<String, WidgetBuilder> routes;

  const NestedNavigator(
      {Key? key,
      required this.navigationKey,
        required this.onGenerateRoute,
      required this.initialRoute,
      required this.routes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Navigator(
        key: navigationKey,
        initialRoute: initialRoute,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }

  Future<bool> _onWillPop() {
    if (navigationKey.currentState!.canPop()) {
      navigationKey.currentState?.pop();
      return Future<bool>.value(false);
    }
    return Future<bool>.value(true);
  }
}

