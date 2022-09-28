import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/services/http_service.dart';

import '../models/apple_model.dart';

abstract class AppleRepository {
  Future<AppleModel> search(String s);

  Future<String> getStoreFront(String token, String userToken);
}

class AppleRepoImpl extends AppleRepository {
  final httpService = GetIt.I.get<HttpService>();

  @override
  Future<AppleModel> search(String s) async {
    var storefront = GetIt.I.get<AuthRepository>().user.storeFront;
    var params = {
      'term': '$s',
      'types': 'songs',
      'limit': '10',
    };
    var query = params.entries.map((p) => '${p.key}=${p.value}').join('&');

    var url = Uri.parse(
        'https://api.music.apple.com/v1/catalog/$storefront/search?$query');
    var res = await appleGet(url);
    print(res);
    return AppleModel.fromJson(jsonDecode(res));
  }

  Future<String> appleGet(Uri url) {
    var repo = GetIt.I.get<AuthRepository>().user;
    var headers = {
      'Authorization': 'Bearer ${repo.appleDevToken}',
      'Music-User-Token': '${repo.token}',
    };
    return httpService.getRequest(url, headers: headers);
  }

  Future<String> applePost(Uri url) {
    var repo = GetIt.I.get<AuthRepository>().user;
    var headers = {
      'Authorization': 'Bearer ${repo.appleDevToken}',
      'Music-User-Token': '${repo.token}',
    };
    return httpService.getRequest(url, headers: headers);
  }

  @override
  Future<String> getStoreFront(String token, String userToken) async {
    var url = Uri.parse('https://api.music.apple.com/v1/me/storefront');
    var headers = {
      'Authorization': 'Bearer $token',
      'Music-User-Token': '$userToken',
    };
    var res = await httpService.getRequest(url, headers: headers);
    return jsonDecode(res)['data'][0]['id'];
  }
}
