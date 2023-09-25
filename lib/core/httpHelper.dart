import 'dart:convert';

import 'package:http/http.dart';
import 'package:posts_clean_arch/core/errors/exception.dart';

class RestResponse {
  final String response;
  final int statusCode;

  RestResponse({required this.response, required this.statusCode});
}
var globalAccessToken ="eyJhbGciOiJSUzI1NiIsImtpZCI6Ik1GUkVTMDJWVERaVVlVSlZYSEc5SkFHWlBZQ1hYMEE0MFVESFNPRU8iLCJ0eXAiOiJhdCtqd3QifQ.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImVkN2EwMzY2LWRkOWQtNDU4NC1iMDE1LWU5NDVkNTVlYTU3NCIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJreWM2QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Imt5YzZAZ21haWwuY29tIiwicmVmZXJyYWwiOiJkZmkiLCJvaV9wcnN0IjoidGVzdC1kb3VibGV3YWxsZXQtd2ViIiwiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LmRvdWJsZXdhbGxldC5pby8iLCJvaV9hdV9pZCI6IjZhMGU0Y2U0LWU4MzItNDQyOC1iNGRiLWU3NzgyMTc4NWUwNiIsInN1YiI6ImVkN2EwMzY2LWRkOWQtNDU4NC1iMDE1LWU5NDVkNTVlYTU3NCIsIm5hbWUiOiJreWM2QGdtYWlsLmNvbSIsImVtYWlsIjoia3ljNkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJjbGllbnRfaWQiOiJ0ZXN0LWRvdWJsZXdhbGxldC13ZWIiLCJvaV90a25faWQiOiJjNzNkYjYyOC1hNTI5LTQyNTEtOWMyNy1mZDA4OTUyMjkzZjgiLCJzY29wZSI6InBob25lIGVtYWlsIHByb2ZpbGUgcm9sZXMiLCJqdGkiOiI4NTE5NjE1Yy0xZWQ5LTRlOTUtYjliMy04ZTZlNTgzN2ZkNDciLCJleHAiOjE2OTU2NDE2NDksImlhdCI6MTY5NTYzOTg0OX0.aK3auey0xqi1zYZPFrQ6AFN_mu7KbL7m1f4-1v_6Qi_6UP_NVJ-iZMRN6JJgEbR31xLWGaqtbPWfMrH9BYE_88Ou5OKlN5jsLkkovpvv_TOGqeyyy5TOkfMkH4gbs-XQ3rI5ChG5aWUwW9iXrcwWPj0pjdt72JCiLs3PeKG_O_hyzuEslp5t7HDyG8jgyGry-Sw9guqE2LWA9aUCWVKe8_jPhn16rxFObqNNcugf-uIe9XTIR_K9EMnGftyAz1BaMjF2hoaoCFe5PgWTirIIj4lPXGIEuCkJ577oxswNzjGZ7E5eGhDVpFCnwikULBkECmEYnZ2es18HausS0OSLFA";
abstract class RestHelper {
  Future<dynamic> get(String url);

  Future<dynamic> post(String url, Map<String, dynamic> body);

  Future<dynamic> patch(String url, Map<String, dynamic> body);

  final headers = {'Content-Type': 'application/json',
  'Authorization': "Bearer $globalAccessToken"};
}

class HttpHelper extends RestHelper {
  final Client client;

  HttpHelper({required this.client});

  @override
  Future<dynamic> get(
    String url,
  ) async {
    try {
      Response httpResponse = await client.get(Uri.parse(url),headers: headers);
      //return httpResponse.body;
      return _handleStatusCode(httpResponse);
    } catch (_) {
      throw UnExpectedException();
    }
  }

  @override
  Future post(String url, Map<String, dynamic> body) async {
    Response httpResponse = await client.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers);

    return _handleStatusCode(httpResponse);
  }

  @override
  Future patch(String url, Map<String, dynamic> body) async {
    Response httpResponse = await client.patch(Uri.parse(url),
        body: jsonEncode(body), headers: headers);

    return _handleStatusCode(httpResponse);
  }

  dynamic _handleStatusCode(Response httpResponse) {
    if (httpResponse.statusCode == 200) {
      var response = apiResponseFromJson(httpResponse.body);
      print(jsonDecode(jsonEncode(httpResponse.body)));
      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == -1) {
        List<dynamic> validationErrors = jsonDecode(jsonEncode(response.data));

        throw DWApiException(message: validationErrors[0]);
      } else if (response.statusCode == 2) {
        List<dynamic> strigaErrors = jsonDecode(jsonEncode(response.data));
        dynamic error = jsonDecode(jsonEncode(strigaErrors[0]));
        throw DWApiException(message: error["msg"]);
      } else if (response.statusCode == 400) {
        throw DWApiException(message: response.data);
      } else {
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

ApiResponse apiResponseFromJson(String str) =>
    ApiResponse.fromJson(json.decode(str));

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
