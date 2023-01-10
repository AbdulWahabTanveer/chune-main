part of 'home_post_bloc.dart';

abstract class HomePostEvent extends Equatable {
  const HomePostEvent();
}

class LoadHomePost extends HomePostEvent {
  final Chune post;

  final bool Function(Chune post) filter;

  LoadHomePost(this.post, this.filter);

  @override
  List<Object> get props => [post,filter];
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
