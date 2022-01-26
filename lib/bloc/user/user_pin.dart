import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/repository/user_code_repo.dart';
import 'package:finance_tracker/bloc/auth/local_auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserPinState {
  const UserPinState();
}

class UserPinEmpty extends UserPinState {
  const UserPinEmpty();
}

class UserPinCorrect extends UserPinState with EquatableMixin {
  final String pinCode;

  const UserPinCorrect(this.pinCode);

  @override
  List<Object?> get props => [pinCode];
}

class UserPinChanged extends UserPinState with EquatableMixin {
  final String _pinCode;

  const UserPinChanged(this._pinCode);

  int get displayedCircles => _pinCode.length;

  @override
  List<Object?> get props => [_pinCode];
}

class UserPinIncorrect extends UserPinState with EquatableMixin {
  final String errorMessage;

  const UserPinIncorrect(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}

class UserPinCubit extends Cubit<UserPinState> {
  final UserRepo repository;
  final LocalAuthCubit localAuthCubit;
  String? _pinCode;
  StreamSubscription? _localAuthCubitSubscription;

  UserPinCubit({required this.repository,required this.localAuthCubit})
      : super(const UserPinEmpty()) {
    _loadPin();
    _localAuthCubitSubscription = localAuthCubit.stream.listen((state) {
      if(state is Authorized){
        debugPrint('correct pin');
        repository.pastePin(_pinCode!);
        emit(UserPinChanged(repository.pin));
        emit(UserPinCorrect(repository.pin));
      }else {
        debugPrint('incorrect pin');
        emit(const UserPinIncorrect('incorrect pin'));
      }
    });
  }

  @override
  Future<void> close() {
    _localAuthCubitSubscription?.cancel();
    return super.close();
  }

  Future<void> _loadPin() async {
    _pinCode = await repository.loadPin();
    debugPrint(_pinCode);
  }

  void onUserPinCodeIncrement(int pinCode) async {
    repository.incrementPin(pinCode);
    emit(UserPinChanged(repository.pin));
    if (repository.pin.length == 4) {
      if (_pinCode != null) {
        if (_pinCode == repository.pin) {
          emit(UserPinCorrect(repository.pin));
        } else {
          debugPrint('pin is incorrect');
          emit(const UserPinIncorrect('incorrect pin'));
        }
      } else {
        await repository.savePin(repository.pin);
        emit(UserPinCorrect(repository.pin));
      }
    }
  }

  void onUserPinDecrement() {
    repository.decrementPin();
    if (repository.pin.isEmpty) {
      emit(const UserPinEmpty());
    } else {
      emit(UserPinChanged(repository.pin));
    }
  }
}
