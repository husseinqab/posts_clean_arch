part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
}

class GetPostCommentsEvent extends CommentEvent{
  final int postId;

  const GetPostCommentsEvent({required this.postId});
  @override
  // TODO: implement props
  List<Object?> get props => [postId];
}
