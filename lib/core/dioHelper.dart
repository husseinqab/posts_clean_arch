import 'package:dio/dio.dart';

import 'httpHelper.dart';

class DioHelper extends RestHelper {
  late Dio client;

  DioHelper(){
    client = Dio();
    client.options = BaseOptions(
      headers: headers,

    );
  }

  @override
  Future<RestResponse> get(String url) async {
    Response<String> dioResponse = await client.get(url);
    return RestResponse(
        response: dioResponse.data!, statusCode: dioResponse.statusCode!);
  }

  @override
  Future post(String url, Map<String, dynamic> body) {
    // TODO: implement post
    throw UnimplementedError();
  }

  @override
  Future patch(String url, Map<String, dynamic> body) {
    // TODO: implement patch
    throw UnimplementedError();
  }
}
