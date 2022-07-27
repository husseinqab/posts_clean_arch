import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/generic_api_calls.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/entities/comment.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/entities/post.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/repositories/post_repository.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_post_comments.dart';

import '../datasources/post_remote_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final GenericCall callApi;

  PostRepositoryImpl({required this.remoteDataSource, required this.callApi});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    return await callApi(() => remoteDataSource.getAllPosts());
  }

  @override
  Future<Either<Failure, List<Comment>>> getPostComments(Params params) async {
    return await callApi(() => remoteDataSource.getPostComments(params));
  }
}
