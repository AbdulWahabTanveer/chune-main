import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/services/player/audio_player.dart';
import 'package:rxdart/rxdart.dart';

import '../models/chune.dart';

class AudioHandler {
  BaseAudioPlayer _player;

  /// Creates an empty [BehaviorSubject] so as to allow new listeners
  /// to get the latest emission on subscription.
  BehaviorSubject<PlayerStatus> _playerState = BehaviorSubject();

  Stream<PlayerStatus> get playerState => _playerState;

  Future<void> init({
    Chune chune,
  }) async {
    _player = GetIt.I.get<BaseAudioPlayer>();
    if(_playerState.isClosed){
      _playerState = BehaviorSubject<PlayerStatus>();
    }

    _player?.playerState?.listen((event) {
      return _playerState.add(event);
    });
    if (chune != null) {
      await addQueueItem(chune);
    }
  }

  Future<void> addQueueItem(Chune mediaItem) async {
    try {
      await _player.queue(mediaItem);
    } catch (e, t) {
      FirebaseFirestore.instance
          .collection('AppleQueueLogs')
          .add({'error': '$e', 'trace': '$t', 'time': "${DateTime.now()}"});
      print(e);
      print(t);
    }
  }

  Future<void> play() async {
    try {
      await _player.resume();
    } catch (e, t) {
      FirebaseFirestore.instance
          .collection('ApplePlayLogs')
          .add({'error': '$e', 'trace': '$t', 'time': "${DateTime.now()}"});
      print(t);
    }
  }

  Future<void> pause() async {
    try {
      await _player.pause();
    } catch (e, t) {
      FirebaseFirestore.instance
          .collection('ApplePlayLogs')
          .add({'error': '$e', 'trace': '$t', 'time': "${DateTime.now()}"});
      print(t);
    }
  }

  Future<void> seek(Duration position) async {
    try {
      await _player.seek(position);
    } catch (e, t) {
      FirebaseFirestore.instance
          .collection('ApplePlayLogs')
          .add({'error': '$e', 'trace': '$t', 'time': "${DateTime.now()}"});
      print(t);
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e, t) {
      FirebaseFirestore.instance
          .collection('ApplePlayLogs')
          .add({'error': '$e', 'trace': '$t', 'time': "${DateTime.now()}"});
      print(t);
    }
  }

  Future<void> dispose() async {
    try {
      await _player?.dispose();
      await _playerState?.close();
    } catch (e, t) {
      print(e);
      print(t);
    }
  }

  Future<PlayerStatus> getPlayerState() async {
    await init();
    return _playerState?.first;
  }
}
