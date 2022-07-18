import 'package:dartz/dartz.dart';
import 'package:posts_clean_arch/core/errors/failure.dart';
import 'package:posts_clean_arch/core/usecase.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/entities/post.dart';
import 'package:posts_clean_arch/fearutres/posts/domain/repositories/post_repository.dart';

class GetAllPosts extends UseCaseListing<Post,NoParams>{
  final PostRepository postRepository;

  GetAllPosts({required this.postRepository});

  @override
  Future<Either<Failure, List<Post>>> call(NoParams params) async {
    return await postRepository.getAllPosts();
  }

}