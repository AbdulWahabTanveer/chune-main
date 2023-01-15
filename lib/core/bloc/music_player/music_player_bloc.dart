import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';

import '../../../Useful_Code/constants.dart';
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
    on<GetAudioEvent>(_onGetAudio);
    on<StopAudioEvent>(_onStopAudio);
    on<ChangePositionEvent>(_onChangePosition);
    on<ChangeStateEvent>(_onChangeState);
    on<PlayNextEvent>(_onPlayNext);
    on<PlayPreviousEvent>(_onPlayPrevious);
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
    // if (state is MusicPlayerInitial) {
    emit(MusicPlayerLoading());
    // }
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
          list: event.chunes),
    );
  }

  FutureOr<void> _onChangePosition(
      ChangePositionEvent event, Emitter<MusicPlayerState> emit) async {
    if (event.position.inSeconds >= event.duration.inSeconds) {
      add(PlayNextEvent());
      return;
    }
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
      Timer(Duration(seconds: 1), () {
        lock = false;
      });
    });
  }

  FutureOr<void> _onPlayNext(
      PlayNextEvent event, Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerLoaded) {
      final cast = state as MusicPlayerLoaded;
      final currentIndex =
          cast.list.indexWhere((element) => element.id == cast.post.id);
      final newIndex =
          currentIndex <= cast.list.length - 1 ? currentIndex + 1 : 0;
      add(SetAudioEvent(cast.list.elementAt(newIndex), chunes: cast.list));
    }
  }

  FutureOr<void> _onPlayPrevious(
      PlayPreviousEvent event, Emitter<MusicPlayerState> emit) async {
    if (state is MusicPlayerLoaded) {
      final cast = state as MusicPlayerLoaded;
      final currentIndex =
          cast.list.indexWhere((element) => element.id == cast.post.id);
      final newIndex =
          currentIndex == 0 ? cast.list.length - 1 : currentIndex - 1;
      add(SetAudioEvent(cast.list.elementAt(newIndex), chunes: cast.list));
    }
  }

  FutureOr<void> _onStopAudio(
      StopAudioEvent event, Emitter<MusicPlayerState> emit) async {
    await player.pause();
    emit(MusicPlayerInitial());
  }

  FutureOr<void> _onGetAudio(
      GetAudioEvent event, Emitter<MusicPlayerState> emit) async {
    try {
      final state = await player.getPlayerState();
      final doc = await FirebaseFirestore.instance
          .collection(chunesCollection)
          .where('playUri', isEqualTo: state.chune.id)
          .limit(1)
          .get();
      final chune = doc.size > 0
          ? Chune.fromMap(doc.docs.first.data()).copyWith(id: doc.docs.first.id)
          : null;
      if (chune != null) {
        emit(
          MusicPlayerLoaded(
              totalDuration: state.chune.totalDuration,
              currentDuration: Duration(milliseconds: state.playbackPosition),
              playing: !state.isPaused,
              post: chune,
              list: []),
        );
      }
    } catch (e, t) {
      print(e);
      print(t);
    }
  }
}
