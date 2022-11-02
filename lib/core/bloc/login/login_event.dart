part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginWithSpotifyEvent extends LoginEvent {}

class LoginWithAppleEvent extends LoginEvent {}

class LoginWithCachedUserEvent extends LoginEvent {
  final MusicSourceModel user;

  LoginWithCachedUserEvent(this.user);
}

class ResetMusicSourceEvent extends LoginEvent {}
