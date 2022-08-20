part of 'music_player_bloc.dart';

abstract class MusicPlayerState extends Equatable {
  const MusicPlayerState();
}

class MusicPlayerInitial extends MusicPlayerState {
  @override
  List<Object> get props => [];
}

class MusicPlayerLoaded extends MusicPlayerState {
  final Duration totalDuration;
  final Duration currentDuration;
  final bool playing;
  final PostDetails post;

  MusicPlayerLoaded(
      {this.totalDuration, this.currentDuration, this.playing, this.post});



  @override
  List<Object> get props => [totalDuration, currentDuration, playing, post];

  MusicPlayerLoaded copyWith({
    Duration totalDuration,
    Duration currentDuration,
    bool state,
    PostDetails post,
  }) {
    return MusicPlayerLoaded(
      totalDuration: totalDuration ?? this.totalDuration,
      currentDuration: currentDuration ?? this.currentDuration,
      playing: state ?? this.playing,
      post: post ?? this.post,
    );
  }
}
