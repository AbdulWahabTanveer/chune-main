import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import '../models/current_user.dart';
import 'apple_repo.dart';
import 'auth_repository.dart';
import 'spotify_repo.dart';
import '../services/http_service.dart';

import '../Useful_Code/constants.dart';
import '../models/chune.dart';
import '../services/cloud_functions_service.dart';

abstract class ShareAChuneRepository {
  Future<List<Chune>> search(String s, {int page = 0});

  Future<bool> shareChune(Chune chune);
}

class ShareAChuneRepoImpl extends ShareAChuneRepository {
  final httpService = GetIt.I.get<HttpService>();
  final functions = GetIt.I.get<CloudFunctionsService>();

  @override
  Future<List<Chune>> search(String s, {int page = 0}) async {
    try {
      final authRepo = GetIt.I.get<AuthRepository>();
      final appleRepo = GetIt.I.get<AppleRepository>();
      final spotifyRepo = GetIt.I.get<SpotifyRepository>();
      switch (authRepo.user.type) {
        case MusicSourceType.spotify:
          final result = await spotifyRepo.search(s, page: page);
          return List<Chune>.from(
            result.tracks.items.map(
              (item) => Chune(
                albumArt: item.album.images[0].url,
                songName: item.name,
                preview: item.previewUrl,
                durationInMills: item.durationMs,
                playUri: item.uri,
                source: MusicSourceType.spotify,
                artistName: item.artists.map((e) => e.name).join(','),
              ),
            ),
          );
        case MusicSourceType.apple:
          final result = await appleRepo.search(s,page: page);
          return List<Chune>.from(
            result.results.songs.data.map(
              (item) => Chune(
                albumArt: item.attributes.artwork.url
                    .replaceFirst(
                        '{w}', '600')
                    .replaceFirst(
                        '{h}', "600"),
                songName: item.attributes.name,
                appleObj:item.toJson(),
                durationInMills: item.attributes.durationInMillis,
                preview: item.attributes.previews[0].url,
                source: MusicSourceType.apple,
                playUri: item.id,
                artistName: item.attributes.artistName,
              ),
            ),
          );
      }
    } catch (e, t) {
      print(e);
      print(t);
    }
    return [];
  }

  @override
  Future<bool> shareChune(Chune chune) async {
    try {
      final doc = await functions.addChune(chune);
      return true;
    } catch (e, t) {
      print(e);
      print(t);
      return false;
    }
  }
}
