import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PasswordBlocState {
  const PasswordBlocState();
}

class HidePassword extends PasswordBlocState {
  const HidePassword();
}
class ShowPassword extends PasswordBlocState {
  const ShowPassword();
}

class PasswordCubit extends Cubit<PasswordBlocState> {
  PasswordCubit() : super(const HidePassword());
  bool _show = false;

  void showPassword(){
    if(_show){
      emit(const HidePassword());
      _show =false;

    }else {
      _show =true;
      emit(const ShowPassword());
    }
  }

}