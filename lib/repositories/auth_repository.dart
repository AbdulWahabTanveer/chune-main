import 'package:flutter/services.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

import '../models/current_user.dart';

abstract class AuthRepository {
  String token;
  Future<CurrentUser> loginWithSpotify();
}

class AuthRepoImpl extends AuthRepository {
  static const CLIENT_ID = '5f70513e09194d8489541fa36fa452c8';
  static const REDIRECT_URL = 'chune://chuneApp.com/callback';


  @override
  Future<CurrentUser> loginWithSpotify() async {
    try {
      var authenticationToken = await SpotifySdk.getAccessToken(
          clientId: CLIENT_ID,
          redirectUrl: REDIRECT_URL,
          scope: 'app-remote-control, '
              'user-modify-playback-state, '
              'playlist-read-private, '
              'playlist-modify-public,user-read-currently-playing');
      super.token = authenticationToken;
      return CurrentUser(token: authenticationToken);
    } on PlatformException catch (e) {
      return Future.error('$e.code: $e.message');
    } on MissingPluginException {
      return Future.error('not implemented');
    }
  }
}
