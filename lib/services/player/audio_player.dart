import '../../models/chune.dart';

abstract class BaseAudioPlayer {
  Stream<PlayerStatus> playerState;

  Future<void> resume();

  Future<void> pause();

  Future<void> seek(Duration duration);

  Future<void> stop();

  Future<void> dispose();

  Future<void> queue(Chune mediaItem);
}

class PlayerStatus {
  final bool isPaused;

  final double playbackSpeed;

  final int playbackPosition;

  final TrackInfo chune;

  PlayerStatus(
    this.isPaused,
    this.playbackSpeed,
    this.playbackPosition,
    this.chune,
  );
}

class TrackInfo {
  final Duration totalDuration;

  TrackInfo(this.totalDuration);
}
