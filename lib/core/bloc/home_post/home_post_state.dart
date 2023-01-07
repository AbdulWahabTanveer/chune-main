part of 'home_post_bloc.dart';

abstract class HomePostState extends Equatable {
  const HomePostState();
}

class HomePostInitial extends HomePostState {
  @override
  List<Object> get props => [];
}

class HomePostLoaded extends HomePostState {
  final Chune post;

  final bool showPost;

  HomePostLoaded(this.post, {this.showPost=false});

  @override
  List<Object> get props => [post,showPost];
}
