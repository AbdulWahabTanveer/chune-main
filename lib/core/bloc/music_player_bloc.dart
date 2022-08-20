import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_audio/just_audio.dart';

import '../../screens/Widgets/Post.dart';

part 'music_player_event.dart';

part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final player = AudioPlayer(); // Create a player
  var lock = false;
  MusicPlayerBloc() : super(MusicPlayerInitial()) {
    on<SetAudioEvent>(_onSetAudio);
    on<ChangePositionEvent>(_onChangePosition);
    on<ChangeStateEvent>(_onChangeState);
    on<SetPositionEvent>(_onSetPosition);
    player.positionStream.listen((event) {
      if(!lock) {
        add(ChangePositionEvent(event: event));
      }
    });
    player.playingStream.listen((event) {
      add(ChangePositionEvent(playing: event));
    });
  }

  FutureOr<void> _onSetAudio(
      SetAudioEvent event, Emitter<MusicPlayerState> emit) async {
    final duration = await player.setUrl(event.post.url);
    player.play();
    emit(
      MusicPlayerLoaded(
        totalDuration: duration,
        currentDuration: Duration.zero,
        playing: player.playing,
        post: event.post,
      ),
    );
  }

  FutureOr<void> _onChangePosition(
      ChangePositionEvent event, Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerLoaded) {
      final cast = state as MusicPlayerLoaded;
      emit(
        cast.copyWith(currentDuration: event.event, state: event.playing),
      );
    }
  }

  FutureOr<void> _onChangeState(
      ChangeStateEvent event, Emitter<MusicPlayerState> emit) async {
    if (player.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Timer bounce;
  FutureOr<void> _onSetPosition(
      SetPositionEvent event, Emitter<MusicPlayerState> emit) async {
    add(ChangePositionEvent(event: event.duration));
    if(!lock){
      lock=true;
    }
    bounce?.cancel();
    bounce = Timer(Duration(milliseconds: 500), ()async {
      await player.seek(event.duration);
      lock=false;
    });
  }
}
