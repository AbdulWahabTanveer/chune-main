part of 'home_post_bloc.dart';

abstract class HomePostEvent extends Equatable {
  const HomePostEvent();
}

class LoadHomePost extends HomePostEvent {
  final Chune post;

  LoadHomePost(this.post);

  @override
  List<Object> get props => [post];
}

class LikeHomePost extends HomePostEvent {
  final Chune post;

  LikeHomePost(this.post);

  @override
  List<Object> get props => [post];
}

class UndoLikeEvent extends HomePostEvent {
  final Chune post;

  UndoLikeEvent(this.post);

  @override
  List<Object> get props => [post];
}
