import 'package:finance_tracker/app/ui/view/main/home/chip/chip_widget.dart';
import 'package:finance_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_balance/account_balance.dart';
import 'bloc/home_bloc.dart';
import 'expenses_income/expenses_income.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<HomeCubit>(),
      lazy: false,
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              children: const [
                AccountBalance(),
                ExpensesIncome(),
                SizedBox(
                  height: 10,
                ),
                CustomChip(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
