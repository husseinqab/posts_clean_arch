import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/post_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_arch/fearutres/users/presentation/pages/users_page.dart';
import 'package:posts_clean_arch/injection_container.dart';

import 'injection_container.dart' as di;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PostBloc>()..add(GetAllPostsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Clean Posts'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersPage()));
                },
                icon: const Icon(Icons.person))
          ],
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            if (state is PostInitial) {
              return const Center(child: Text('Posts page'));
            } else if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PostsSucceeded) {
              return PostsPage(state.posts);
            } else if (state is PostsFailed) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

