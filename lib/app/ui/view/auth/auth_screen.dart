import 'package:finance_tracker/app/ui/shared/app_top_navigation.dart';
import 'package:flutter/material.dart';
/// [LoginScreen]  main screen of auth flow
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:const [
              TopNavigation(
                headerText: 'Login',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
