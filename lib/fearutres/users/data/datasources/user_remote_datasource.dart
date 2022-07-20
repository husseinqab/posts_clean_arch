import 'package:posts_clean_arch/core/errors/exception.dart';
import 'package:posts_clean_arch/fearutres/users/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSourceImpl extends UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<List<UserModel>> getAllUsers() async {
    http.Response response = await client.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode != 200){
      throw ServerException();
    }

    return userFromJson(response.body);
  }

}