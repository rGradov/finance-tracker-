part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

/// loading account balance form sql data base
class HomeLoading extends HomeState {
  const HomeLoading();

  @override
  List<Object?> get props => [];
}

/// disputed empty value for account balance
class HomeStateEmpty extends HomeState {
  const HomeStateEmpty();

  /// displayed current currency

  /// use if for show account balance

  @override
  List<Object?> get props => [];
}

/// when account balance was loaded
class HomeStateLoaded extends HomeState {
  const HomeStateLoaded();

  @override
  List<Object?> get props => [];
}
