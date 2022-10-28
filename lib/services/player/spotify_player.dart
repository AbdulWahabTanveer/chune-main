import 'dart:async';

import 'package:newapp/models/chune.dart';
import 'package:newapp/services/player/audio_player.dart';
import 'package:rxdart/rxdart.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyPlayer extends BaseAudioPlayer {
  Timer timer;

  StreamController<int> controller;
  final interval = Duration(seconds: 1);

  @override
  Stream<PlayerStatus> get playerState => Rx.combineLatest2<PlayerState, int, PlayerStatus>(
    SpotifySdk.subscribePlayerState(),
    _timedCounter(),
        (event, b) => PlayerStatus(
      event.isPaused,
      event.playbackSpeed,
      b,
      TrackInfo(
        Duration(milliseconds: event.track.duration),
      ),
    ),
  );

  Stream<int> _timedCounter() {
    controller = StreamController<int>(
        onListen: startTimer,
        onPause: stopTimer,
        onResume: startTimer,
        onCancel: stopTimer);
    return controller.stream;
  }

  void startTimer() {
    timer = Timer.periodic(interval, tick);
  }

  void tick(_) async {
    final pos = await SpotifySdk.getPlayerState();
    controller.add(pos.playbackPosition);
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  Future<void> dispose() async {
    controller?.close();
    timer?.cancel();
    SpotifySdk.getCrossFadeState();
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
  Future<void> queue(Chune mediaItem, {bool playNow = true}) async {
    if (playNow) {
      await SpotifySdk.play(spotifyUri: mediaItem.playUri);
    } else {
      await SpotifySdk.queue(spotifyUri: mediaItem.playUri);
    }
  }
}
