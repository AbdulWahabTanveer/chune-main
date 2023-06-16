import 'dart:convert';

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:launch_review/launch_review.dart';
import 'package:music_kit/music_kit.dart';
import 'apple_repo.dart';
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
  static const CLIENT_ID =
      '2410f3e1923f472095a62ebf4792e638'; // '5f70513e09194d8489541fa36fa452c8';
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
              // 'playlist-read-private, '
              'user-read-currently-playing');
      print(authenticationToken);
      await SpotifySdk.connectToSpotifyRemote(
          clientId: CLIENT_ID, redirectUrl: REDIRECT_URL);
      final currentUser = MusicSourceModel(
          token: authenticationToken, type: MusicSourceType.spotify);
      await _saveUser(currentUser);
      return currentUser;
    } on PlatformException catch (e) {
      print("Code -------> $e");
      if (e.code == 'CouldNotFindSpotifyApp') {
        LaunchReview.launch(
            iOSAppId: 'id324684580', androidAppId: 'com.spotify.music');

        Fluttertoast.showToast(msg: '${e.message}');
      }
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      return Future.error('not implemented');
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  @override
  Future<MusicSourceModel> loginWithApple() async {
    final _musicKitPlugin = MusicKit();

    final developerToken = //TODO: GET FROM API
        'eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6IjlSVUxNTDRVMlUifQ.eyJpc3MiOiJEWlE2U1JaWEtRIiwiZXhwIjoxNjc5NTk4MDA5LCJpYXQiOjE2NjM4MjEwMDl9.o35PTIc1QY_C_AdOp0ziaD2cCuTyTRvwLntz0I4uSTwXxli3WpnH2qE-NW_ZlvWTwRHDItjkLuVik5OOUQkutA';
    if (Platform.isIOS) {
      await _musicKitPlugin.requestAuthorizationStatus(
          // token,
          );

      final devToken = await _musicKitPlugin.requestDeveloperToken();
      final userToken = await _musicKitPlugin.requestUserToken(devToken);
      final storeFront = await GetIt.I
          .get<AppleRepository>()
          .getStoreFront(devToken, userToken);
      final currentUser = MusicSourceModel(
        token: userToken,
        type: MusicSourceType.apple,
        storeFront: storeFront,
        appleDevToken: devToken,
      );
      await _saveUser(currentUser);
      return currentUser;
    } else {
      await _musicKitPlugin.initialize(developerToken);

      final userToken = await _musicKitPlugin.requestUserToken(developerToken);
      final storeFront = await GetIt.I
          .get<AppleRepository>()
          .getStoreFront(developerToken, userToken);
      final currentUser = MusicSourceModel(
        token: userToken,
        type: MusicSourceType.apple,
        storeFront: storeFront,
        appleDevToken: developerToken,
      );
      await _saveUser(currentUser);
      return currentUser;
    }
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
