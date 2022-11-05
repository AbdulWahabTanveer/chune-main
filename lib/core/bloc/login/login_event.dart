part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginWithSpotifyEvent extends LoginEvent {}

class LoginWithAppleEvent extends LoginEvent {}

class LoginWithCachedUserEvent extends LoginEvent {

  LoginWithCachedUserEvent();
}

class ResetMusicSourceEvent extends LoginEvent {}
