import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/models/chune.dart';
import 'package:newapp/services/player/audio_player.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import '../../models/current_user.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/spotify_repo.dart';

class SpotifyPlayer extends BaseAudioPlayer {
  Timer timer;
  final spotifyRepo = GetIt.I.get<SpotifyRepository>();

  StreamController<int> controller;
  final interval = Duration(seconds: 1);

  @override
  Stream<PlayerStatus> get playerState =>
      // SpotifySdk.subscribePlayerState().map((event) =>
      //     PlayerStatus(
      //   event.isPaused,
      //   event.playbackSpeed,
      //   event.,
      //   TrackInfo(
      //     Duration(milliseconds: event.track?.duration??0),
      //   ),
      // ),);
      Rx.combineLatest2<PlayerState, int, PlayerStatus>(
        SpotifySdk.subscribePlayerState(),
        _timedCounter(),
        (event, b) => PlayerStatus(
          event.isPaused,
          event.playbackSpeed,
          b,
          TrackInfo(Duration(milliseconds: event.track?.duration ?? 0),
              event.track?.uri),
        ),
      );

  Stream<int> _timedCounter() {
    controller = StreamController<int>(
        onPause: stopTimer,
        onCancel: stopTimer);
    return controller.stream;
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(interval, tick);
  }

  void tick(_) async {
    try {
      final pos = await SpotifySdk.getPlayerState();
      controller.add(pos.playbackPosition);
    } catch (e, t) {
      GetIt.I.get<AuthRepository>().getLoggedInUser();
      print(e);
      print(t);
    }
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  Future<void> dispose() async {
    await stop();
    controller?.close();
    stopTimer();
    await SpotifySdk.disconnect();
  }

  @override
  Future<void> pause() {
    stopTimer();
    return SpotifySdk.pause();
  }

  @override
  Future<void> resume() {
    startTimer();
    return SpotifySdk.resume();
  }

  @override
  Future<void> seek(Duration duration) {
    return SpotifySdk.seekTo(positionedMilliseconds: duration.inMilliseconds);
  }

  @override
  Future<void> stop() {
    return SpotifySdk.pause();
  }

  @override
  Future<void> queue(Chune mediaItem) async {
    if (mediaItem.source == MusicSourceType.apple) {
      final result = await spotifyRepo.search(mediaItem.songName);
      if (result?.tracks?.items != null && result.tracks.items.isNotEmpty) {
        var track = result.tracks.items.firstWhere(
          (element) => element.artists
              .map((e) => e.name)
              .join(',')
              .contains(mediaItem.artistName.split(',')[0]),
          orElse: () => result.tracks.items.first,
        );
        return SpotifySdk.play(spotifyUri: track.uri);
      } else {
        Fluttertoast.showToast(msg: 'ERROR');
      }
    } else {
      await SpotifySdk.play(spotifyUri: mediaItem.playUri);
      // await SpotifySdk.queue(spotifyUri: mediaItem.playUri);
    }
  }
}
