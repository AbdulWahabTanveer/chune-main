part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}
class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginState {
  final MusicSourceModel user;

  LoginSuccessState(this.user);

  @override
  List<Object> get props => [user];
}

class LoginErrorState extends LoginState {
  final String user;

  LoginErrorState(this.user);

  @override
  List<Object> get props => [user];
}
