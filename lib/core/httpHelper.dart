import 'dart:convert';

import 'package:http/http.dart';
import 'package:posts_clean_arch/core/errors/exception.dart';

class RestResponse {
  final String response;
  final int statusCode;

  RestResponse({required this.response, required this.statusCode});
}

abstract class RestHelper {
  Future<dynamic> get(String url);

  Future<dynamic> post(String url, Map<String, dynamic> body);

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
  Future post(String url, Map<String, dynamic> body) async {
      Response httpResponse =
          await client.post(Uri.parse(url), body: jsonEncode(body), headers: headers);

      return _handleStatusCode(httpResponse);
    }

  dynamic _handleStatusCode(Response httpResponse) {
    if (httpResponse.statusCode == 200) {

      var response = apiResponseFromJson(httpResponse.body);
      if (response.statusCode == 200){
        return response.data;
      } else if (response.statusCode == -1){
        List<dynamic> validationErrors = jsonDecode(jsonEncode(response.data));

        throw DWApiException(message: validationErrors[0]);
      } else if (response.statusCode == 2){
        List<dynamic> strigaErrors = jsonDecode(jsonEncode(response.data));
        dynamic error = jsonDecode(jsonEncode(strigaErrors[0]));
        throw DWApiException(message: error["msg"]);

      } else {
        final message = jsonDecode(jsonEncode(response.message));
        throw DWApiException(message: response.message);
      }
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

ApiResponse apiResponseFromJson(String str) => ApiResponse.fromJson(json.decode(str));

class ApiResponse<T> {
  final int statusCode;
  final String message;
  final T data;

  ApiResponse({
    required this.statusCode,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
    statusCode: json["statusCode"],
    message: json["message"],
    data: json["data"],
  );

}



