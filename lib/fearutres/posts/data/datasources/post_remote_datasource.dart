import 'dart:convert';

import 'package:posts_clean_arch/core/httpHelper.dart';
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
  final RestHelper client;

  // final http.Client client;

  PostRemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    // RestResponse response = await client.get('https://jsonplaceholder.typicode.com/posts');
    try {
      var body = await client.get('https://jsonplaceholder.typicode.com/posts');

      return List<PostModel>.from(
          json.decode(body).map((x) => PostModel.fromJson(x)));
    } catch(_){
      throw UnExpectedException();
    }
  }

  @override
  Future<List<CommentModel>> getPostComments(Params params) async {
    // TODO: implement getPostComments
    // RestResponse response = await client.get(
    //     'https://jsonplaceholder.typicode.com/posts/${params.postId}/comments');
    var body = await client.get(
        'https://jsonplaceholder.typicode.com/posts/${params.postId}/comments');

    return List<CommentModel>.from(
        json.decode(body).map((x) => CommentModel.fromJson(x)));
  }
}
