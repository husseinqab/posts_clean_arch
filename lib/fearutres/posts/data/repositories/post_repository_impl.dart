import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/exception.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/entities/comment.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/entities/post.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/repositories/post_repository.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_post_comments.dart';

import '../../../../core/network/network_info.dart';
import '../datasources/post_remote_datasource.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostRepositoryImpl({required this.remoteDataSource,required this.networkInfo});
  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getAllPosts();
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }

  }

  @override
  Future<Either<Failure, List<Comment>>> getPostComments(Params params) async {
    if (await networkInfo.isConnected){
      try {
        final response = await remoteDataSource.getPostComments(params);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NoInternetFailure());
    }
  }
}