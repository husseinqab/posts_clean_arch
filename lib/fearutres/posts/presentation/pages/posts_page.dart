import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/comment_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/comment_state.dart';

import '../../../../injection_container.dart ';
import '../../domain/entities/comment.dart';
import '../../domain/entities/post.dart';

class PostsPage extends StatelessWidget {
  final List<Post> posts;

  const PostsPage(this.posts, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          Post post = posts[index];
          return ListTile(
            title: Text(post.title),
            subtitle: Text(post.body),
            trailing: Text(post.id.toString()),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CommentsPage(postId: post.id)));
            },
          );
        });
  }
}

class CommentsPage extends StatelessWidget {
  final int postId;

  const CommentsPage({Key? key,required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for Post Id $postId'),
      ),
      body: BlocProvider<CommentBloc>(
        create: (context) => sl<CommentBloc>()..add(GetPostCommentsEvent(postId: postId)),
        child: BlocBuilder<CommentBloc, CommentState>(
          builder: (context, state) {
            if (state is CommentInitial) {
              return const Center(child: Text('Posts page'));
            } else if (state is CommentsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CommentsSucceeded) {
              return ListView.builder(
                  itemCount: state.comments.length,
                  itemBuilder: (context, index) {
                    Comment comment = state.comments[index];
                    return ListTile(
                      title: Text(comment.email ),
                      subtitle: Text(comment.body),
                      trailing: Text(comment.id.toString()),
                    );
                  });
            } else if (state is CommentsFailed) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}



