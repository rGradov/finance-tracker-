import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> _mainNavigation = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> _authNavigation = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get mainNavigation =>_mainNavigation;
  GlobalKey<NavigatorState> get authNavigation =>_authNavigation;

  Future<dynamic> mainNavigateTo({required String name}) {
  return _mainNavigation.currentState!.pushNamed(name);
  }
  Future<dynamic> authNavigateTo({required String name}) {
    return _authNavigation.currentState!.pushNamed(name);
  }
}