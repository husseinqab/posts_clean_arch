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

  Future<dynamic> patch(String url, Map<String, dynamic> body);

  static var token = 'eyJhbGciOiJSUzI1NiIsImtpZCI6IlpRUEg2UU1FTlhLNE5LOTRaTFlSOEIwRVMwRzNHOEc2OFdHQVVGN0QiLCJ0eXAiOiJhdCtqd3QifQ.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjE0OTJlYmYxLTI0N2UtNGVkYi1iOWE4LTc5YmFhNGU2OGZmNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJzYXJhaC5zbGltYW4yMjJAZ21haWwuY29tIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoic2FyYWguc2xpbWFuMjIyQGdtYWlsLmNvbSIsInJlZmVycmFsIjoiZGZpIiwiaHR0cDovL3NjaGVtYXMubWljcm9zb2Z0LmNvbS93cy8yMDA4LzA2L2lkZW50aXR5L2NsYWltcy9yb2xlIjoiVXNlciIsIm9pX3Byc3QiOiJ0ZXN0LWRvdWJsZXdhbGxldC13ZWIiLCJpc3MiOiJodHRwczovL3NhbmRib3guZG91Ymxld2FsbGV0LmlvLyIsIm9pX2F1X2lkIjoiNDIzZjVkNTItMGZhNy00N2Y1LTllNmMtMjBlMjZhMDk0NmZiIiwic3ViIjoiMTQ5MmViZjEtMjQ3ZS00ZWRiLWI5YTgtNzliYWE0ZTY4ZmY3IiwibmFtZSI6InNhcmFoLnNsaW1hbjIyMkBnbWFpbC5jb20iLCJlbWFpbCI6InNhcmFoLnNsaW1hbjIyMkBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJyb2xlIjoiVXNlciIsImNsaWVudF9pZCI6InRlc3QtZG91Ymxld2FsbGV0LXdlYiIsIm9pX3Rrbl9pZCI6IjA1ZTY3YmI4LTkwZjMtNGUzYy04MGE3LWI2YzQ0NzY2Y2NhOCIsInNjb3BlIjoicGhvbmUgZW1haWwgcHJvZmlsZSByb2xlcyIsImp0aSI6ImI1YTE5MGEyLWM2NTEtNDY4ZS05NmM4LWY1ODUyYWZkODk3MiIsImV4cCI6MTY5NTMzMzU4NiwiaWF0IjoxNjk1MzMxNzg2fQ.UwvvaY1Jy8qn3GIESYJHlczzxn5vMRzTJiyAxb5cGCTB1hIEACuFrf2WP5OZFEhPTNCBbhH1Hr_8N5rcRwMpGX7HYwsExGT6E23s3jy1H6VGkkJZdVzQFiW1VKbq_PDOeZZ4bkkhi2kqi15WVOIlBCpCWryvVMJ9RaQLqErz5w0CHrKijgt4Tt1c2TVPuHq0qcuet77W6rRMWPUgqMDAmAvPPMCEUa1SDRGg7lEXJLiVaZ3FXQMu2Lq4Ru4DGbpm0OK_TnxwgD4vyeZUAw7Yy6UZu5EUeeBH_jrCY3TBfFKWDzvPLw1kgxM8-m1c7PesdQBiOFUvO4IcC3bu2a9y7w';
  final headers = {'Content-Type': 'application/json',
  'Authorization': "Bearer $token"};
}

class HttpHelper extends RestHelper {
  final Client client;

  HttpHelper({required this.client});

  @override
  Future<dynamic> get(
    String url,
  ) async {
    try {
      Response httpResponse = await client.get(Uri.parse(url));
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
