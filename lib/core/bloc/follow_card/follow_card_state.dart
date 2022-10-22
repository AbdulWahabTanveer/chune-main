part of 'follow_card_bloc.dart';

abstract class FollowCardState extends Equatable {
  const FollowCardState();
}

class FollowCardInitial extends FollowCardState {
  @override
  List<Object> get props => [];
}

class FollowCardLoaded extends FollowCardState {
  final ProfileModel card;

  FollowCardLoaded(this.card);

  @override
  List<Object> get props => [card];
}
