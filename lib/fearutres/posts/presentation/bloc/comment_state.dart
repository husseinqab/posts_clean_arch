import 'package:equatable/equatable.dart';

import '../../domain/entities/comment.dart';

abstract class CommentState extends Equatable {
  const CommentState();
}

class CommentInitial extends CommentState {
  @override
  List<Object> get props => [];
}

class CommentsLoading extends CommentState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class CommentsSucceeded extends CommentState {
  final List<Comment> comments;

  const CommentsSucceeded({required this.comments});

  @override
  // TODO: implement props
  List<Object?> get props => [comments];
}

class CommentsFailed extends CommentState {
  final String message;
  const CommentsFailed({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
