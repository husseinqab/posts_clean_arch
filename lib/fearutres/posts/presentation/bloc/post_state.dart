part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
}

class PostInitial extends PostState {
  @override
  List<Object> get props => [];
}

class PostsLoading extends PostState {
  @override
  List<Object> get props => [];
}

class PostsSucceeded extends PostState {
  final List<Post> posts;

  const PostsSucceeded({required this.posts});
  @override
  List<Object> get props => [posts];
}

class PostsFailed extends PostState {
  final String message;

  const PostsFailed(this.message);
  @override
  List<Object> get props => [message];
}

