import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/apple_repo.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/repositories/share_a_chune_repo.dart';
import 'package:newapp/services/http_service.dart';

import '../repositories/spotify_repo.dart';
import 'audio_service.dart';

class Injector {
  static Future<void> init(VoidCallback appRunner) async {
    GetIt.I.registerSingleton<HttpService>(HttpService());
    GetIt.I.registerSingleton<AuthRepository>(AuthRepoImpl());
    GetIt.I.registerSingleton<SpotifyRepository>(SpotifyRepoImpl());
    GetIt.I.registerSingleton<AppleRepository>(AppleRepoImpl());
    GetIt.I.registerSingleton<ShareAChuneRepository>(ShareAChuneRepoImpl());
    GetIt.I.registerSingleton<BdiAudioHandler>(BdiAudioHandler());
    appRunner();
  }
}
