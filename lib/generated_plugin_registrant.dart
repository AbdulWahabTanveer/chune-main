//
// Generated file. Do not edit.
//

// ignore_for_file: directives_ordering
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: depend_on_referenced_packages

import 'package:audio_session/audio_session_web.dart';
import 'package:flutter_web_auth/src/flutter_web_auth_web.dart';
import 'package:just_audio_web/just_audio_web.dart';
import 'package:spotify_sdk/spotify_sdk_web.dart';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';

// ignore: public_member_api_docs
void registerPlugins(Registrar registrar) {
  AudioSessionWeb.registerWith(registrar);
  FlutterWebAuthPlugin.registerWith(registrar);
  JustAudioPlugin.registerWith(registrar);
  SpotifySdkPlugin.registerWith(registrar);
  registrar.registerMessageHandler();
}
