import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:music_kit/music_kit.dart';
import 'package:newapp/models/chune.dart';
import 'package:newapp/models/current_user.dart';
import 'package:newapp/services/player/audio_player.dart';
import 'package:rxdart/rxdart.dart';

import '../../Useful_Code/constants.dart';
import '../../repositories/apple_repo.dart';

class ApplePlayer extends BaseAudioPlayer {
  final _musicKitPlugin = MusicKit();
  final appleRepo = GetIt.I.get<AppleRepository>();

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
                  milliseconds:
                      ((queue?.currentEntry?.item ?? {})['attributes'] ??
                              {})['durationInMillis'] ??
                          0),
              queue?.currentEntry?.id ?? ""),
        ),
      );

  // #docregion better-stream
  Stream<int> _timedCounter(Duration interval, [int maxCount]) {
    controller = StreamController<int>(onPause: stopTimer, onCancel: stopTimer);
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
    stopTimer();
    return _musicKitPlugin.stop();
  }

  @override
  Future<void> pause() {
    stopTimer();
    return _musicKitPlugin.pause();
  }

  @override
  Future<void> resume() async {
    startTimer();
    if (Platform.isIOS && !(await _musicKitPlugin.isPreparedToPlay)) {
      await _musicKitPlugin.prepareToPlay();
    }
    return _musicKitPlugin.play();
  }

  @override
  Future<void> seek(Duration duration) {
    Fluttertoast.showToast(msg: 'Cannot seek on Apple Music player');
    // return _musicKitPlugin.beginSeekingBackward();
  }

  @override
  Future<void> stop() {
    return _musicKitPlugin.stop();
  }

  @override
  Future<void> queue(Chune mediaItem) async {
    if (mediaItem.appleObj == null || mediaItem.appleObj.isEmpty) {
      if(mediaItem.source == MusicSourceType.apple){
        final result = await appleRepo.getSong(mediaItem.playUri);
        return _musicKitPlugin
            .setQueueWithItems("songs", items: [result]);
      }
      final result = await appleRepo.search("${mediaItem.songName}",limit: 25);
      if (result?.results?.songs?.data != null &&
          result.results.songs.data.isNotEmpty) {
        var track = result.results.songs.data.firstWhere(
          (element) =>
              element.attributes.durationInMillis
                  ==mediaItem.durationInMills,
          orElse: () => result.results.songs.data.first,
        );
        return _musicKitPlugin
            .setQueueWithItems("songs", items: [track.toJson()]);
      }
    }
    return _musicKitPlugin
        .setQueueWithItems("songs", items: [mediaItem.appleObj]);
  }
}
