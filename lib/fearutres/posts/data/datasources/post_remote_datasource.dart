import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_post_comments.dart';

import '../../../../core/errors/exception.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

abstract class PostRemoteDataSource {
  /// calls the https://jsonplaceholder.typicode.com/posts endpoint
  /// Throws a [ServerException] for all error codes
  Future<List<PostModel>> getAllPosts();
  Future<List<CommentModel>> getPostComments(Params params);
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    http.Response response = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200){
      throw ServerException();
    }
    return List<PostModel>.from(json.decode(response.body).map((x) => PostModel.fromJson(x)));
  }

  @override
  Future<List<CommentModel>> getPostComments(Params params) async {
    // TODO: implement getPostComments
    http.Response response = await client.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/${params.postId}/comments"),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 200){
      throw ServerException();
    }

    return List<CommentModel>.from(json.decode(response.body).map((x) => CommentModel.fromJson(x)));
  }
}
