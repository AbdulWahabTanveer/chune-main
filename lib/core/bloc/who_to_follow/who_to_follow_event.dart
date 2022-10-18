part of 'who_to_follow_bloc.dart';

abstract class WhoToFollowEvent {
  const WhoToFollowEvent();
}

class LoadWhoToFollowEvent extends WhoToFollowEvent {}

class FollowUserEvent extends WhoToFollowEvent {
  final int index;

  FollowUserEvent(this.index);
}

class UndoFollowEvent extends WhoToFollowEvent {
  final int index;

  UndoFollowEvent(this.index);
}
