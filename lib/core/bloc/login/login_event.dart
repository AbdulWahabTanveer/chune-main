part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginWithSpotifyEvent extends LoginEvent {}
class LoginWithAppleEvent extends LoginEvent {}
class ResetMusicSourceEvent extends LoginEvent {}
