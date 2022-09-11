part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final CurrentUser user;

  LoginSuccessState(this.user);

  @override
  List<Object> get props => [user];
}
