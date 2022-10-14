import 'dart:async';

import 'package:newapp/models/chune.dart';
import 'package:newapp/services/player/audio_player.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

class SpotifyPlayer extends BaseAudioPlayer {
  Timer timer;



  @override
  Stream<PlayerStatus> playerState = SpotifySdk.subscribePlayerState().map(
    (event) {
      print(event.playbackRestrictions.toJson());
      return PlayerStatus(
        event.isPaused,
        event.playbackSpeed,
        event.playbackPosition,
        TrackInfo(
          Duration(milliseconds: event.track.duration),
        ),
      );
    },
  );

  @override
  Future<void> dispose() async {
    SpotifySdk.getCrossFadeState();
    await SpotifySdk.disconnect();
  }

  @override
  Future<void> pause() {
    return SpotifySdk.pause();
  }

  @override
  Future<void> resume() {
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
