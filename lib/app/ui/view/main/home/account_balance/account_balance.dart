import 'package:finance_tracker/app/ui/themes/app_theme.dart';
import 'package:finance_tracker/app/ui/view/main/home/account_balance/bloc/account_balance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../main.dart';

class AccountBalance extends StatelessWidget {
  const AccountBalance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>getIt<AccountBalanceCubit>(),
      child: FractionallySizedBox(
        widthFactor: 0.5,
        alignment: Alignment.center,
        child: Column(
          children: const [
            _AccountBalanceText(),
            SizedBox(
              height: 10,
            ),
            _AccountBalanceValue(),

            /// TODO: added Account balance
            /// TODO: added value
          ],
        ),
      ),
    );
  }
}

class _AccountBalanceText extends StatelessWidget {
  const _AccountBalanceText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      fontFamily: 'Inter',
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: AppColor.baseLight[20],
    );
    return Text(
      'Account Balance',
      style: _style,
    );
  }
}

class _AccountBalanceValue extends StatelessWidget {
  const _AccountBalanceValue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle(
      fontFamily: 'Inter',
      fontSize: 35,
      fontWeight: FontWeight.w500,
      color: AppColor.baseDark[75],
    );
    return BlocBuilder<AccountBalanceCubit, AccountBalanceState>(
        builder: (_, state) {
      if (state is AccountBalanceLoaded) {

        return Text(
          state.accountBalance,
          style: _style,
        );
      } else if (state is AccountBalanceEmpty){
        return Text(
          '0.0',
          style: _style,
        );
      }else {
        return Text('error',style: _style,);
      }
    });
  }
}
