part of 'follow_card_bloc.dart';

abstract class FollowCardEvent extends Equatable {
  const FollowCardEvent();
}

class LoadFollowCard extends FollowCardEvent {
  final ProfileModel card;

  LoadFollowCard(this.card);

  @override
  List<Object> get props => [card];
}

class FollowUserEvent extends FollowCardEvent {
  final ProfileModel card;

  FollowUserEvent(this.card);

  @override
  List<Object> get props => [card];
}

class UndoFollowEvent extends FollowCardEvent {
  final ProfileModel card;

  UndoFollowEvent(this.card);

  @override
  List<Object> get props => [card];
}

