import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/helper.dart';
import 'package:posts_clean_arch/core/usecase.dart';

import '../../domain/entities/post.dart';
import '../../domain/usecases/get_all_posts.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final GetAllPosts getAllPosts;

  PostBloc(this.getAllPosts) : super(PostInitial()) {
    on<PostEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(PostsLoading());
        final eitherPostsOrFailure = await getAllPosts(NoParams());

        eitherPostsOrFailure.fold(
            (failure) =>
                emit(PostsFailed(Helpers.mapFailureToMessage(failure))),
            (posts) => emit(PostsSucceeded(posts: posts)));
      }
    });
  }
}
