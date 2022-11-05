part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent {
  const MusicPlayerEvent();
}

class SetAudioEvent extends MusicPlayerEvent {
  final Chune post;

  final List<Chune> chunes;

  SetAudioEvent(this.post, {this.chunes});
}

class ChangePositionEvent extends MusicPlayerEvent {
  final Duration position;
  final bool playing;

  final Duration duration;

  ChangePositionEvent({this.position, this.playing, this.duration});
}

class ChangeStateEvent extends MusicPlayerEvent {
  final bool playing;

  ChangeStateEvent(this.playing);
}

class PlayNextEvent extends MusicPlayerEvent {}

class PlayPreviousEvent extends MusicPlayerEvent {}

class SetPositionEvent extends MusicPlayerEvent {
  final Duration duration;

  SetPositionEvent({this.duration});
}
