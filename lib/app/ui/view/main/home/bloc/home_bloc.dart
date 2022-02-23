import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/ui/view/main/home/account_balance/bloc/account_balance_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AccountBalanceCubit _balanceCubit;
  StreamSubscription<AccountBalanceState>? _accountBalanceSubscription;

  HomeCubit(this._balanceCubit) : super(const HomeStateEmpty()) {
    _accountBalanceSubscription = _balanceCubit.stream.listen((state) {
      print(state.toString());
      if (state is AccountBalanceLoaded) {
        _loadedState(state);
      }
    });
  }

  @override
  Future<void> close() {
    _accountBalanceSubscription?.cancel();
    return super.close();
  }

  /// use it whe data is loaded
  Future<void> _loadedState(AccountBalanceLoaded accountBalance) async {
    if (accountBalance.value >= 0) {
      emit(const HomeStateLoaded());
    } else {
      emit(const HomeStateEmpty());
    }
  }
}
