import 'package:finance_tracker/app/repository/auth_repository.dart';
import 'package:finance_tracker/app/repository/user_code_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SingUpState {
  const SingUpState();
}

class EmptyFields extends SingUpState {
  const EmptyFields();
}

class FieldsIsValid extends SingUpState {
  const FieldsIsValid();
}

class FieldsIsInValid extends SingUpState {
  final String errorMessage;

  const FieldsIsInValid(this.errorMessage);
}

class TermsISAgree extends SingUpState {
  const TermsISAgree();
}

class TermsISDisagree extends SingUpState {
  const TermsISDisagree();
}

class SignUpCubit extends Cubit<SingUpState> {
  final UserRepo _userRepository;
  final AuthRepository _authRepository;
  SignUpCubit(this._userRepository,this._authRepository) :
        super(const EmptyFields());
  FieldStatus _emailState = FieldStatus.empty;
  FieldStatus _passwordState = FieldStatus.empty;
  FieldStatus _rePassword = FieldStatus.empty;

  void updateEmail(String email) {
    final _status = _userRepository.updateEmail(email);
    _emailState = _status;
  }

  void updatePassword(String password) {
    final _status = _userRepository.updatePassword(password);
    _passwordState = _status;

  }

  void updateRePassword(String rePassword) {
    if (rePassword.length == _userRepository.user.password.length) {
      final _status = _userRepository.checkPassword(rePassword);
      _rePassword = _status;

    }
  }

  void signUpClick() async{
    if (_emailState == FieldStatus.empty) {
      emit(const FieldsIsInValid('email is empty'));
    } else if (_emailState == FieldStatus.inValid) {
      emit(const FieldsIsInValid('email is inValid'));
    } else {

    }
    if (_passwordState == FieldStatus.empty) {
      emit(const FieldsIsInValid('email is empty'));
    } else if (_passwordState == FieldStatus.inValid) {
      emit(const FieldsIsInValid('email is inValid'));
    } else {

    }
    if (_rePassword == FieldStatus.empty) {
      emit(const FieldsIsInValid('email is empty'));
    } else if (_rePassword == FieldStatus.inValid) {
      emit(const FieldsIsInValid('email is inValid'));
    } else {

    }
    if (_emailState == FieldStatus.valid && _rePassword == FieldStatus.valid &&
        _passwordState == FieldStatus.valid){
      await _authRepository.emailSignIn(email: _userRepository.user.email, password: _userRepository.user.password);
    }
  }
}
