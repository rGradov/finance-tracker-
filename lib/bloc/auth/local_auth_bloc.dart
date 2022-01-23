import 'package:finance_tracker/app/repository/local_auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class LocalAutState {
  const LocalAutState();
}

class Authorized extends LocalAutState {
  const Authorized();
}
class NotAuthorized extends LocalAutState {
  const NotAuthorized();
}

class LocalAuthCubit extends Cubit<LocalAutState> {
  final LocalAuthRepository _repository;
  LocalAuthCubit( this._repository) : super(const NotAuthorized());

  Future<void> checkAuth()async{
    await _repository.auth();
  }



}