part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class NewUserState extends ProfileState {
  @override
  List<Object> get props => [];
}

class ExistingUserState extends ProfileState {
  @override
  List<Object> get props => [];
}
