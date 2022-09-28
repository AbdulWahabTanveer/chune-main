import 'package:newapp/models/chune.dart';
import 'package:newapp/services/player/audio_player.dart';

class ApplePlayer extends BaseAudioPlayer {
  @override
  Future<void> dispose() {
    // TODO: implement dispose
    throw UnimplementedError();
  }

  @override
  Future<void> pause() {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<void> resume() {
    // TODO: implement play
    throw UnimplementedError();
  }

  @override
  Future<void> seek(Duration duration) {
    // TODO: implement seek
    throw UnimplementedError();
  }

  @override
  Future<void> stop() {
    // TODO: implement stop
    throw UnimplementedError();
  }

  @override
  Future<void> queue(Chune mediaItem) {
    // TODO: implement queue
    throw UnimplementedError();
  }
}
