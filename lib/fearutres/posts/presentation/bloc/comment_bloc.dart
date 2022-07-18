import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:posts_clean_arch/core/helper.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/comment_state.dart';

import '../../domain/usecases/get_post_comments.dart';

part 'comment_event.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetPostComments getPostComments;

  CommentBloc(this.getPostComments) : super(CommentInitial()) {
    on<CommentEvent>((event, emit) async {
      if (event is GetPostCommentsEvent) {
        emit(CommentsLoading());

        final eitherFailureOrComments =
            await getPostComments(Params(postId: event.postId));

        eitherFailureOrComments.fold(
            (failure) => emit(
                CommentsFailed(message: Helpers.mapFailureToMessage(failure))),
            (comments) => emit(CommentsSucceeded(comments: comments)));
      }
    });
  }
}
