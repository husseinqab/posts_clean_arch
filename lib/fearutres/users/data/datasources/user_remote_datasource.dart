import 'package:posts_clean_arch/core/errors/exception.dart';
import 'package:posts_clean_arch/fearutres/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/httpHelper.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final RestHelper client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getAllUsers() async {
   var body = await client.get("https://jsonplaceholder.typicode.com/users");
    return userFromJson(body);
  }

}