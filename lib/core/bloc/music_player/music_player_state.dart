part of 'music_player_bloc.dart';

abstract class MusicPlayerState extends Equatable {
  const MusicPlayerState();
}

class MusicPlayerInitial extends MusicPlayerState {
  @override
  List<Object> get props => [];
}

class MusicPlayerLoading extends MusicPlayerState {
  @override
  List<Object> get props => [];
}

class MusicPlayerLoaded extends MusicPlayerState {
  final Duration totalDuration;
  final Duration currentDuration;
  final bool playing;
  final Chune post;
  final List<Chune> list;

  MusicPlayerLoaded(
      {this.totalDuration,
      this.currentDuration,
      this.playing,
      this.post,
      this.list});

  @override
  List<Object> get props =>
      [totalDuration, currentDuration, playing, post, list];

  MusicPlayerLoaded copyWith(
      {Duration totalDuration,
      Duration currentDuration,
      bool state,
      PostDetails post,
      List<Chune> list}) {
    return MusicPlayerLoaded(
        totalDuration: totalDuration ?? this.totalDuration,
        currentDuration: currentDuration ?? this.currentDuration,
        playing: state ?? this.playing,
        post: post ?? this.post,
        list: list ?? this.list);
  }
}
