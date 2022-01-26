import 'package:equatable/equatable.dart';
import 'package:finance_tracker/app/repository/user_code_repo.dart';
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
  final UserRepo _repository;
  String? _pinCode;

  UserPinCubit(this._repository) : super(const UserPinEmpty()){
    _loadPin();
  }

  Future<void> _loadPin()async {
   _pinCode = await _repository.loadPin();
   debugPrint(_pinCode);
  }
  void onUserPinCodeIncrement(int pinCode) async{
    _repository.incrementPin(pinCode);
    emit(UserPinChanged(_repository.pin));
    if (_repository.pin.length == 4) {
      if(_pinCode !=null){
        if(_pinCode == _repository.pin){
          emit(UserPinCorrect(_repository.pin));
        }else {
          debugPrint('pin is incorrect');
          emit(const UserPinIncorrect('incorrect pin'));
        }
      }else {
        await _repository.savePin(_repository.pin);
        emit(UserPinCorrect(_repository.pin));

      }
    }
  }
  void onUserPinDecrement(){
    _repository.decrementPin();
    if(_repository.pin.isEmpty){
      emit(const UserPinEmpty());
    }else {
      emit(UserPinChanged(_repository.pin));
    }

  }
}
