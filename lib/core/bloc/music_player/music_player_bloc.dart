import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../models/chune.dart';
import '../../../screens/Widgets/Post.dart';
import '../../../services/audio_service.dart';
import '../../../services/cloud_functions_service.dart';

part 'music_player_event.dart';

part 'music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final player = GetIt.I<AudioHandler>();
  final functions = GetIt.I<CloudFunctionsService>();

  var lock = false;

  MusicPlayerBloc() : super(MusicPlayerInitial()) {
    on<SetAudioEvent>(_onSetAudio);
    on<ChangePositionEvent>(_onChangePosition);
    on<ChangeStateEvent>(_onChangeState);
    on<SetPositionEvent>(_onSetPosition);
    player.playerState.listen((event) {
      if (!lock) {
        add(ChangePositionEvent(
          position: Duration(milliseconds: event.playbackPosition),
          duration: event.chune.totalDuration,
          playing: !event.isPaused,
        ));
      }
    });
  }

  FutureOr<void> _onSetAudio(
      SetAudioEvent event, Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerInitial) {
      emit(MusicPlayerLoading());
    }
    await player.init(chune: event.post);
    await player.play();
    if (event.post.id != null) {
      functions.listenChune(event.post.id);
    }
    emit(
      MusicPlayerLoaded(
        totalDuration: Duration.zero,
        currentDuration: Duration.zero,
        playing: false,
        post: event.post,
      ),
    );
  }

  FutureOr<void> _onChangePosition(
      ChangePositionEvent event, Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerLoaded) {
      final cast = state as MusicPlayerLoaded;
      emit(
        cast.copyWith(
            currentDuration: event.position,
            state: event.playing,
            totalDuration: event.duration),
      );
    }
  }

  FutureOr<void> _onChangeState(
      ChangeStateEvent event, Emitter<MusicPlayerState> emit) async {
    if (event.playing) {
      await player.pause();
    } else {
      await player.play();
    }
  }

  Timer bounce;

  FutureOr<void> _onSetPosition(
      SetPositionEvent event, Emitter<MusicPlayerState> emit) async {
    add(ChangePositionEvent(position: event.duration));
    if (!lock) {
      lock = true;
    }
    bounce?.cancel();
    bounce = Timer(Duration(milliseconds: 500), () async {
      await player.seek(event.duration);
      lock = false;
    });
  }
}
