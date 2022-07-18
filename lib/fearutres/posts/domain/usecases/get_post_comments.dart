
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/repositories/post_repository.dart';

import '../entities/comment.dart';

class GetPostComments extends UseCaseListing<Comment,Params>{
  final PostRepository postRepository;

  GetPostComments({required this.postRepository});

  @override
  Future<Either<Failure, List<Comment>>> call(Params params) async {
    final response = await postRepository.getPostComments(params);
    return response;
  }

}


class Params extends Equatable {
  final int postId;
  const Params({required this.postId});

  @override
  // TODO: implement props
  List<Object?> get props => [postId];
}