import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AddedNewWalletState {
  const AddedNewWalletState();
}

class KeyboardIsOpened extends AddedNewWalletState with EquatableMixin {
  const KeyboardIsOpened();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class InitialState extends AddedNewWalletState with EquatableMixin {
  const InitialState();

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WalletStateChanged extends AddedNewWalletState with EquatableMixin {
  final String _valetName;

  const WalletStateChanged(this._valetName);

  @override
  List<Object?> get props => [_valetName];
}

class NewWalletCubit extends Cubit<AddedNewWalletState> {
  NewWalletCubit(AddedNewWalletState initialState)
      : super(initialState);

  void walletNameChanged(String name) {
    emit(WalletStateChanged(name));
  }
  void onTextFieldTap(){
    emit(const KeyboardIsOpened());
  }
}
