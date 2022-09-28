import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/services/http_service.dart';

import '../models/spotify_model.dart';

abstract class SpotifyRepository {
  Future<SpotifyModel> search(String s);
}

class SpotifyRepoImpl extends SpotifyRepository {
  final httpService = GetIt.I.get<HttpService>();

  @override
  Future<SpotifyModel> search(String s) async {
    var token = GetIt.I.get<AuthRepository>().user.token;
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    var params = {
      'q': '$s',
      'type': 'track',
      'limit': '10',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse('https://api.spotify.com/v1/search?$query');
    final response = await httpService.getRequest(url,headers: headers);
    return SpotifyModel.fromJson(jsonDecode(response));
  }
}
