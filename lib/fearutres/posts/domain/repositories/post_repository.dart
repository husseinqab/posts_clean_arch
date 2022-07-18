import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/entities/post.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/usecases/get_post_comments.dart';

import '../../../../core/errors/failure.dart';
import '../entities/comment.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, List<Comment>>> getPostComments(Params params);
}
