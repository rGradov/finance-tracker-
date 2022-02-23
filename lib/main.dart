import 'package:finance_tracker/app/ui/my_app/my_app.dart';
import 'package:finance_tracker/app/ui/navigation/navigation_service.dart';
import 'package:finance_tracker/app/ui/view/main/home/account_balance/bloc/account_balance_bloc.dart';
import 'package:finance_tracker/app/ui/view/main/home/bloc/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// This is our global ServiceLocator
GetIt getIt = GetIt.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// Service locator

  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  getIt.registerLazySingleton<AccountBalanceCubit>(() => AccountBalanceCubit());
  getIt.registerLazySingleton<HomeCubit>(
      () => HomeCubit(getIt<AccountBalanceCubit>()));

  final MyApp app = MyApp();
  runApp(app);
}
