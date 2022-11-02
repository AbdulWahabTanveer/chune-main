import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:music_kit/music_kit.dart';
import 'package:newapp/repositories/apple_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import '../models/current_user.dart';

abstract class AuthRepository {
  MusicSourceModel user;

  Future<MusicSourceModel> loginWithSpotify();

  Future<MusicSourceModel> loginWithApple();

  MusicSourceModel getLoggedInUser();

  void clearUser();
}

class AuthRepoImpl extends AuthRepository {
  static const CLIENT_ID = '5f70513e09194d8489541fa36fa452c8';
  static const REDIRECT_URL = 'chune://chuneApp.com/callback';

  final prefs = GetIt.I.get<SharedPreferences>();

  @override
  Future<MusicSourceModel> loginWithSpotify() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: CLIENT_ID,
          redirectUrl: REDIRECT_URL,
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      print(authenticationToken);
      await SpotifySdk.connectToSpotifyRemote(
          clientId: CLIENT_ID, redirectUrl: REDIRECT_URL);
      final currentUser = MusicSourceModel(
          token: authenticationToken, type: MusicSourceType.spotify);
      await _saveUser(currentUser);
      return currentUser;
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      return Future.error('not implemented');
    }
  }

  @override
  Future<MusicSourceModel> loginWithApple() async {
    final _musicKitPlugin = MusicKit();

    final token = //TODO: GET FROM API
        'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjlSVUxNTDRVMlUifQ.eyJpc3MiOiJEWlE2U1JaWEtRIiwiZXhwIjoxNjc5NTk4MDA5LCJpYXQiOjE2NjM4MjEwMDl9.o35PTIc1QY_C_AdOp0ziaD2cCuTyTRvwLntz0I4uSTwXxli3WpnH2qE-NW_ZlvWTwRHDItjkLuVik5OOUQkutA';
    await _musicKitPlugin.initialize(
      token,
    );

    final userToken = await _musicKitPlugin.requestUserToken(token);
    final storeFront =
        await GetIt.I.get<AppleRepository>().getStoreFront(token, userToken);
    await _musicKitPlugin.play();
    final currentUser = MusicSourceModel(
      token: userToken,
      type: MusicSourceType.apple,
      storeFront: storeFront,
      appleDevToken: token,
    );
    await _saveUser(currentUser);
    return currentUser;
  }

  _saveUser(MusicSourceModel currentUser) {
    super.user = currentUser;
    prefs.setString('currentUser', jsonEncode(currentUser.toMap()));
  }

  @override
  MusicSourceModel getLoggedInUser() {
    try {
      final user = MusicSourceModel.fromMap(
        jsonDecode(
          prefs.getString('currentUser'),
        ),
      );
      super.user = user;
      return user;
    } catch (e, t) {
      print(e);
      print(t);
      return null;
    }
  }

  @override
  void clearUser() {
    prefs.remove('currentUser');
  }
}
