import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:newapp/models/current_user.dart';
import 'package:newapp/repositories/apple_repo.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/repositories/spotify_repo.dart';
import 'package:newapp/services/http_service.dart';

import '../models/chune.dart';

abstract class ShareAChuneRepository {
  Future<List<Chune>> search(String s);
}

class ShareAChuneRepoImpl extends ShareAChuneRepository {
  final httpService = GetIt.I.get<HttpService>();

  @override
  Future<List<Chune>> search(String s) async {
    final authRepo = GetIt.I.get<AuthRepository>();
    final appleRepo = GetIt.I.get<AppleRepository>();
    final spotifyRepo = GetIt.I.get<SpotifyRepository>();
    switch (authRepo.user.type) {
      case UserType.spotify:
        final result = await spotifyRepo.search(s);
        return List<Chune>.from(
          result.tracks.items.map(
            (item) => Chune(
              albumArt: item.album.images[0].url,
              songName: item.name,
              isSelected: false,
              preview: item.previewUrl,
              spotifyUri: item.uri,
              artistName: item.artists.map((e) => e.name).join(','),
            ),
          ),
        );
      case UserType.apple:
        final result = await appleRepo.search(s);
        return List<Chune>.from(
          result.results.songs.data.map(
            (item) => Chune(
              albumArt: item.attributes.artwork.url
                  .replaceFirst('{w}', item.attributes.artwork.width.toString())
                  .replaceFirst(
                      '{h}', item.attributes.artwork.height.toString()),
              songName: item.attributes.name,
              isSelected: false,
              preview: item.attributes.previews[0].url,
              artistName: item.attributes.artistName,
            ),
          ),
        );
    }
    return [];
  }
}
