import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/bloc/post_bloc.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_arch/injection_container.dart';
import 'package:posts_clean_arch/route_generator.dart';

import 'core/simple_bloc_observer.dart';
import 'injection_container.dart' as di;
Future<void> main() async {
  // creates a zone
  await runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize other stuff here...
    di.init();
    Bloc.observer = SimpleBlocObserver();
    runApp(MyApp());
    // or here
    runApp(MyApp());
  }, (exception, stackTrace) async {
     debugPrint(exception.toString());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
        ),
      ),
      title: 'Material App',
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
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
/*          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/users");
                },
                icon: const Icon(Icons.person)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/airlines");
                },
                icon: const Icon(Icons.airplanemode_active)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/passengers");
                },
                icon: const Icon(Icons.people)),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/KYC");
                },
                icon: const Icon(Icons.insert_drive_file))
          ],*/
        ),
        /*body: BlocBuilder<PostBloc, PostState>(
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
        ),*/
        body: Center(
          child: ElevatedButton(
            child: Text("Start KYC"),
              onPressed: () {
                Navigator.pushNamed(context, "/KYC");
              },
        ),
      )),
    );
  }
}
