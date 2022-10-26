part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class CheckProfileExistsEvent extends ProfileEvent {
  final String userId;

  CheckProfileExistsEvent(this.userId);
}

class LoadProfileEvent extends ProfileEvent {
  final String userId;

  LoadProfileEvent(this.userId);
}

class SetUserProfileEvent extends ProfileEvent {
  final ProfileModel profile;

  const SetUserProfileEvent(this.profile);
}

class LogoutProfileEvent extends ProfileEvent {}
