import 'dart:async';
import 'dart:io';

import 'package:music_kit/music_kit.dart';
import 'package:newapp/models/chune.dart';
import 'package:newapp/services/player/audio_player.dart';
import 'package:rxdart/rxdart.dart';

class ApplePlayer extends BaseAudioPlayer {
  final _musicKitPlugin = MusicKit();

  StreamController<int> controller;
  Timer timer;

  final interval = Duration(seconds: 1);

  @override
  Stream<PlayerStatus> get playerState =>
      Rx.combineLatest3<MusicPlayerQueue, MusicPlayerState, int, PlayerStatus>(
        MusicKit().onPlayerQueueChanged,
        MusicKit().onMusicPlayerStateChanged,
        _timedCounter(Duration(seconds: 1)),
        (queue, state, duration) => PlayerStatus(
          state.playbackStatus != MusicPlayerPlaybackStatus.playing,
          1.0,
          duration,
          TrackInfo(
            Duration(
                milliseconds: queue.currentEntry.item['attributes']
                    ['durationInMillis']),
          ),
        ),
      );

  // #docregion better-stream
  Stream<int> _timedCounter(Duration interval, [int maxCount]) {
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
    final pos = await _musicKitPlugin.playbackTime;
    controller.add(pos.toInt());
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  Future<void> dispose() {
    controller?.close();
    timer?.cancel();
    return _musicKitPlugin.stop();
  }

  @override
  Future<void> pause() {
    stopTimer();
    return _musicKitPlugin.pause();
  }

  @override
  Future<void> resume()async {
    startTimer();
    if (Platform.isIOS && !( await _musicKitPlugin.isPreparedToPlay)) {
    await _musicKitPlugin.prepareToPlay();
    }
    return _musicKitPlugin.play();
  }

  @override
  Future<void> seek(Duration duration) {
    // return _musicKitPlugin.beginSeekingBackward();
  }

  @override
  Future<void> stop() {
    return _musicKitPlugin.stop();
  }

  @override
  Future<void> queue(Chune mediaItem) {
    return _musicKitPlugin
        .setQueueWithItems("songs", items: [mediaItem.appleObj]);
  }
}
