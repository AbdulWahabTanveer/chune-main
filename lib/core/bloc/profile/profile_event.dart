part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class CheckProfileExistsEvent extends ProfileEvent {
  final String userId;

  CheckProfileExistsEvent(this.userId);
}
