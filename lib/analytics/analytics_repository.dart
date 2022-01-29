import 'package:finance_tracker/analytics/analytics_helpers.dart';
import 'package:finance_tracker/analytics/analytics_irepository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalyticsRepository implements AnalyticsIRepository {
  final FirebaseAnalytics _analytics;

  AppAnalyticsRepository() : _analytics = FirebaseAnalytics.instance;

  @override
  Future<void> init()async {
    await _analytics.setDefaultEventParameters({
      'version':'0.1',
      'language':'ru'
    });
  }

  @override
  Future<void> signInMethods({required SignInMethod method}) {
    throw UnimplementedError();
  }

  @override
  Future<void> logAppOpen() async{
    await _analytics.logAppOpen();
  }

  @override
  Future<void> logOnBoarding() async{
    await _analytics.logTutorialBegin();
  }

  @override
  Future<void> onBoardingIsDone() async{
    await _analytics.logTutorialComplete();
  }

  @override
  Future<void> screenTracking(String route)async {
    await _analytics.setCurrentScreen(screenName: route);
  }


}
