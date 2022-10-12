part of 'create_username_bloc.dart';

abstract class CreateUsernameEvent {
  const CreateUsernameEvent();
}

class CheckUsernameEvent extends CreateUsernameEvent {
  final String username;

  CheckUsernameEvent(this.username);
}

class CreateUserProfileEvent extends CreateUsernameEvent {
  final String userId;
  final ProfileModel profile;

  CreateUserProfileEvent(this.userId, this.profile);
}
