import 'dart:convert';

import 'package:http/http.dart';
import 'package:posts_clean_arch/core/errors/exception.dart';

class RestResponse {
  final String response;
  final int statusCode;

  RestResponse({required this.response, required this.statusCode});
}
var globalAccessToken ="eyJhbGciOiJSUzI1NiIsImtpZCI6IldSV0FJVkhHRUVDREM3R1lDQ1RFX0RCVDZaVFRFTVlESi1HUUNaWEIiLCJ0eXAiOiJhdCtqd3QifQ.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6ImM0ODFjNjhjLTI1MDMtNDA2Ni1hNjk1LWEzNmE3ZGMyN2IxNyIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJreWM1QGdtYWlsLmNvbSIsImh0dHA6Ly9zY2hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL2VtYWlsYWRkcmVzcyI6Imt5YzVAZ21haWwuY29tIiwicmVmZXJyYWwiOiJkZmkiLCJvaV9wcnN0IjoidGVzdC1kb3VibGV3YWxsZXQtd2ViIiwiaXNzIjoiaHR0cHM6Ly9zYW5kYm94LmRvdWJsZXdhbGxldC5pby8iLCJvaV9hdV9pZCI6ImM5NzI4MzcxLTQ0MjctNDQ1Ny04NDAxLTc1OWU1MmFiNTQzYiIsInN1YiI6ImM0ODFjNjhjLTI1MDMtNDA2Ni1hNjk1LWEzNmE3ZGMyN2IxNyIsIm5hbWUiOiJreWM1QGdtYWlsLmNvbSIsImVtYWlsIjoia3ljNUBnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJjbGllbnRfaWQiOiJ0ZXN0LWRvdWJsZXdhbGxldC13ZWIiLCJvaV90a25faWQiOiJiMzFiZjk5YS1kZjQ4LTRjZWItYTA2Ny0zZGQzYTUxYWY0YzEiLCJzY29wZSI6InBob25lIGVtYWlsIHByb2ZpbGUgcm9sZXMiLCJqdGkiOiJmYTAzNWM3ZS0yZWJiLTQ5ZDYtODZlZS1hYTAyNTZjNzQxZWQiLCJleHAiOjE2OTU0NzMzMDUsImlhdCI6MTY5NTQ3MTUwNX0.cyFYJ6HklGX2pF5ca2OaPoFDtaWWZoE4v2_lAcbTrSxnKSRgyilRzJsIZ5oZCI8AqfeyW2BfEpYq7pd8uiHyN_kHba6MghlbKiq_JQwp0WdrVCY_NQknBU17IoX6j8WpmGHsy4efP_rq8MH22DfmoVmNRNr5OHjsm99kMAB7F0qclmTeKkjwKjnZbU7UX9t6_LHMHSTDcBf3XILFIKJMf8rVMUUwctK8VdDxRsDi20dbz2tDKjyx76CAyn6Ne6lh4K-bGizaXzC-2z0Py0JOlpnyeaWJiN4HvIxLxNluSLrlnerb4ryfTon_phpBIuBmmgbTr9tMDPt4GwI1Plarbg";

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
