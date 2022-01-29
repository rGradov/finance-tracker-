import 'package:finance_tracker/analytics/analytics_helpers.dart';

abstract class AnalyticsIRepository {
  Future<void> init() async {}

  Future<void> signInMethods({required SignInMethod method}) async {}
  Future<void> logAppOpen()async{}
  Future<void> logOnBoarding()async{}
  Future<void> onBoardingIsDone()async{}
  Future<void> screenTracking(String route)async{}
}
