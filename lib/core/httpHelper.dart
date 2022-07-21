import 'package:http/http.dart';

abstract class RestHelper {
  Future<Response> get(String url);
}

class HttpHelper extends RestHelper {
  final Client client;

  HttpHelper({required this.client});

  static final headers = {
    'Content-Type': 'application/json'
  };

  @override
  Future<Response> get(String url,) {
    return client.get(Uri.parse(url), headers: headers);
  }
}