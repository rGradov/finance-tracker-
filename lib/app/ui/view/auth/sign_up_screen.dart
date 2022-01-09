import 'package:finance_tracker/app/ui/shared/app_top_navigation.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
                headerText: 'Sign Up',
                isBlack: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
