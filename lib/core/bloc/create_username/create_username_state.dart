part of 'create_username_bloc.dart';

abstract class CreateUsernameState extends Equatable {
  const CreateUsernameState();
}

class CreateUsernameInitial extends CreateUsernameState {
  @override
  List<Object> get props => [];
}

class UsernameLoadingState extends CreateUsernameState {
  @override
  List<Object> get props => [];
}

class CheckingUsernameState extends UsernameLoadingState {
  @override
  List<Object> get props => [];
}

class CreatingUsernameState extends UsernameLoadingState {
  @override
  List<Object> get props => [];
}

class UsernameExistsState extends CreateUsernameState {
  @override
  List<Object> get props => [];
}

class UsernameAvailableState extends CreateUsernameState {
  final String username;

  UsernameAvailableState(this.username);

  @override
  List<Object> get props => [username];
}

class UsernameCreateSuccessState extends CreateUsernameState {
  final ProfileModel profile;

  UsernameCreateSuccessState(this.profile);

  @override
  List<Object> get props => [profile];
}

class UsernameCreateErrorState extends CreateUsernameState {
  final String error;

  UsernameCreateErrorState(this.error);

  @override
  List<Object> get props => [error];
}
