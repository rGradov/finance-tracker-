import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/model/models.dart';
import 'package:finance_tracker/app/utils/currency_converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_balance_state.dart';

class AccountBalanceCubit extends Cubit<AccountBalanceState> {
  AccountBalanceCubit() : super(const AccountBalanceLoading()){
    _loadingData();
  }

  Future _loadingData() async {
    Future<void>.delayed(const Duration(seconds: 5)).then<void>((v) => emit(
        const AccountBalanceLoaded(currency: CurrencyType.dollars, value: 15)));
  }
}
