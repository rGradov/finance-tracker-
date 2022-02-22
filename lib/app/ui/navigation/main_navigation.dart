import 'package:animations/animations.dart';
import 'package:finance_tracker/app/ui/navigation/auth_navigation.dart';
import 'package:finance_tracker/app/ui/navigation/navigation_service.dart';
import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/app/ui/view/added_new_account.dart';
import 'package:finance_tracker/app/ui/view/auth/onboarding/onboarding_screen.dart';
import 'package:finance_tracker/app/ui/view/main/home/home_screen.dart';
import 'package:finance_tracker/app/ui/view/pin_screen.dart';
import 'package:finance_tracker/app/ui/view/setup_account_screen.dart';
import 'package:finance_tracker/main.dart';
import 'package:flutter/material.dart';

const AUTHPREFIX = '/auth/';

abstract class AppRoutes {
  static const mainRoute = '/';
  static const setupAccountRoute = '/setup';
  static const addedNewAccount = '/setup/add';
  static const homeRoute = '/home';
  static const loginRoute = '$AUTHPREFIX${AuthRouteNames.initialRoute}';
}

class MainNavigation {
  final AppRouteUtils _routeUtils = AppRouteUtils();

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        AppRoutes.mainRoute: (_) => const PinScreen(),
        AppRoutes.setupAccountRoute: (_) => const SetupAccountScreen(),
        AppRoutes.addedNewAccount: (_) => const AddedNewAccountScreen(),
      };

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    late Widget _screen;
    if (settings.name == AppRoutes.addedNewAccount) {
      _screen = const AddedNewAccountScreen();
    } else if (settings.name == AppRoutes.mainRoute) {
      _screen = const OnBoardingScreen();
    } else if (settings.name == AppRoutes.setupAccountRoute) {
      _screen = const SetupAccountScreen();
    } else if (settings.name!.startsWith(AUTHPREFIX)) {
      final _subRoute = settings.name!.substring(AUTHPREFIX.length);
      _screen = AuthFlow(
        authFlowRoute: _subRoute,
        title: _subRoute,
      );
    } else if(settings.name == AppRoutes.homeRoute){
      _screen = const HomeScreen();
    }

    else {
      throw Exception('Unknown route: ${settings.name}');
    }
    return _routeUtils.sharedAxisTransition(
        screen: _screen, settings: settings);
  }
}

@immutable
class AuthFlow extends StatefulWidget {
  static _AuthFlowState of(BuildContext context) {
    return context.findAncestorStateOfType<_AuthFlowState>()!;
  }

  final String authFlowRoute;
  final String title;

  const AuthFlow({Key? key,
    required this.title,
    required this.authFlowRoute}) : super(key: key);

  @override
  _AuthFlowState createState() => _AuthFlowState();
}

class _AuthFlowState extends State<AuthFlow> {

  @override
  void didUpdateWidget(covariant AuthFlow oldWidget) {
    if(widget.title !=oldWidget.title){

    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    const  _style = TextStyle(
        color:Colors.black,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        fontSize: 18);
    return WillPopScope(
        child: Scaffold(
          /// TODO: FIX APP BAR
          appBar: AppBar(
            centerTitle: true,
            
            title: Text('topBar'.toUpperCase(),style: _style,),
            backgroundColor: Colors.white,
            actionsIconTheme: const IconThemeData(color: Colors.black),
            iconTheme:  const IconThemeData(color: Colors.black),
            bottomOpacity: 0.0,
            elevation: 0.0,
          ),

          body: Navigator(
            key: getIt<NavigationService>().authNavigation,
            initialRoute: widget.authFlowRoute,
            onGenerateRoute: AuthNavigation().onGenerateRoute,
          ),
        ),

        onWillPop: _onWillPop);
  }

  Future<bool> _onWillPop() {
    /// TODO: FIX POP
    final _navigatorState =
        getIt<NavigationService>().authNavigation.currentState;
    if (_navigatorState!.canPop()) {
      _navigatorState.pop();
      // Navigator.of(context).pop();

    } else {}
    return Future.value(true);
  }
}




class AppRouteUtils {
  PageRouteBuilder<dynamic> sharedAxisTransition(
      {required Widget screen, required RouteSettings settings}) {
    return PageRouteBuilder<dynamic>(
      settings: settings,
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) =>
          screen,
      transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
      ) =>
          SharedAxisTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        transitionType: SharedAxisTransitionType.horizontal,
        child: child,
      ),
    );
  }
}
