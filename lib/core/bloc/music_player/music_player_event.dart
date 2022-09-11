part of 'music_player_bloc.dart';

abstract class MusicPlayerEvent {
  const MusicPlayerEvent();
}

class SetAudioEvent extends MusicPlayerEvent {
  final Chune post;

  SetAudioEvent(this.post);
}

class ChangePositionEvent extends MusicPlayerEvent {
  final Duration event;
  final bool playing;

  ChangePositionEvent({this.event, this.playing});
}
class ChangeStateEvent extends MusicPlayerEvent{}
class SetPositionEvent extends MusicPlayerEvent{
  final Duration duration;

  SetPositionEvent({this.duration});

}
