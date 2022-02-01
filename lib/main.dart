import 'package:finance_tracker/app/ui/my_app/my_app.dart';
import 'package:finance_tracker/app/ui/navigation/navigation_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );

  /// Service locator
  final MyApp app = MyApp();
  runApp(app);
}
