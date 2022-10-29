part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
}

class UserProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileLoadingState extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileLoadedState extends UserProfileState {
  final ProfileModel profile;

  UserProfileLoadedState(this.profile);

  @override
  List<Object> get props => [profile];
}

class UserProfileErrorState extends UserProfileState {
  final String error;

  UserProfileErrorState(this.error);

  @override
  List<Object> get props => [error];
}
