part of 'user_profile_bloc.dart';

abstract class UserProfileEvent {
  const UserProfileEvent();
}

class LoadUserProfileEvent extends UserProfileEvent {
  final String userId;

  const LoadUserProfileEvent(this.userId);
}
