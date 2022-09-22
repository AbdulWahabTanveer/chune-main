import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:newapp/repositories/auth_repository.dart';
import 'package:newapp/services/http_service.dart';

abstract class AppleRepository {
  // Future<AppleModel> search(String s);
}

class AppleRepoImpl extends AppleRepository {
  final httpService = GetIt.I.get<HttpService>();

  // @override
  // Future<AppleModel> search(String s) async {
  //   var repo = GetIt.I.get<AuthRepository>();
  //   var headers = {
  //     'Authorization': 'Bearer [developer token]',
  //     'Music-User-Token': '[music user token]',
  //   };

  //   var url = Uri.parse('https://api.music.apple.com/v1/me/library/songs');
  //   var res = await httpService.getRequest(url, headers: headers);
  //
  //   print(res);
  // }
}
