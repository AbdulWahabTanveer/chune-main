import 'package:http/http.dart';

class HttpService {
  Future<String> getRequest(Uri url, {Map<String, String> headers}) async {
    final response = await get(url, headers: headers);
    return response.body;
  }
}
