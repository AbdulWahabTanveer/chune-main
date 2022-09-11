import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/services/http_service.dart';

import '../repositories/spotify_repo.dart';

class Injector {
  static Future<void> init(VoidCallback appRunner) async {
    GetIt.I.registerSingleton<HttpService>(HttpService());
    GetIt.I.registerSingleton<AuthRepository>(AuthRepoImpl());
    GetIt.I.registerSingleton<SpotifyRepository>(SpotifyRepoImpl());
    appRunner();
  }
}
