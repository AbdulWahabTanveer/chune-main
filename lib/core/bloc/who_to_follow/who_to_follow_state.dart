part of 'who_to_follow_bloc.dart';

abstract class WhoToFollowState extends Equatable {
  const WhoToFollowState();
}

class WhoToFollowInitial extends WhoToFollowState {
  @override
  List<Object> get props => [];
}

class WhoToFollowLoadingState extends WhoToFollowState {
  @override
  List<Object> get props => [];
}

class WhoToFollowSuccessState extends WhoToFollowState {
  final List<ProfileModel> users;

  WhoToFollowSuccessState(this.users);

  @override
  List<Object> get props => [users];
}

class WhoToFollowErrorState extends WhoToFollowState {
  final String error;

  WhoToFollowErrorState(this.error);

  @override
  List<Object> get props => [error];
}
