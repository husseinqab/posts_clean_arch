import 'package:http/http.dart';
import 'package:posts_clean_arch/core/errors/exception.dart';

class RestResponse {
  final String response;
  final int statusCode;

  RestResponse({required this.response, required this.statusCode});
}

abstract class RestHelper {
  Future<dynamic> get(String url);

  Future<dynamic> post(String url, Map<dynamic, String> body);

  final headers = {'Content-Type': 'application/json'};
}

class HttpHelper extends RestHelper {
  final Client client;

  HttpHelper({required this.client});

  @override
  Future<dynamic> get(
    String url,
  ) async {
    try {
      Response httpResponse =
          await client.get(Uri.parse(url));
      //return httpResponse.body;
       return _handleStatusCode(httpResponse);
    } catch (_) {
      throw UnExpectedException();
    }
  }

  @override
  Future post(String url, Map<dynamic, String> body) async {
    try {
      Response httpResponse =
          await client.post(Uri.parse(url), body: body, headers: headers);

      //return httpResponse.body;
      return _handleStatusCode(httpResponse);
    } catch (_) {
      throw UnExpectedException();
    }
  }

  dynamic _handleStatusCode(Response httpResponse) {
    if (httpResponse.statusCode == 200) {
      return httpResponse.body;
    } else if (httpResponse.statusCode == 401) {
      throw UnAuthorizedException();
    } else if (httpResponse.statusCode == 404) {
      throw NotFoundException();
    } else if (httpResponse.statusCode == 500) {
      throw ServerException();
    } else {
      throw UnExpectedException();
    }
  }
}


