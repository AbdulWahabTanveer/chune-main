part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final ProfileModel profile;

  const ProfileLoadedState(this.profile);

  @override
  List<Object> get props => [profile];
}
