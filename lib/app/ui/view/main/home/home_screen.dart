import 'package:flutter/material.dart';

import 'expenses_income/expenses_income.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body:  SizedBox.expand(
        child: ExpensesIncome(),
      ),
    );
  }
}



