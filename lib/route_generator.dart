import 'package:flutter/material.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_arch/fearutres/users/presentation/pages/users_page.dart';
import 'package:posts_clean_arch/main.dart';

import 'fearutres/airlines/presentation/pages/airlines_page.dart';
import 'fearutres/passengers/presentation/pages/passengers_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/users':
        // Validation of correct data type
        return MaterialPageRoute(
          builder: (_) => UsersPage(),
        );
      case '/comments':
        // Validation of correct data type
        if (args is int) {
          return MaterialPageRoute(
            builder: (_) => CommentsPage(
              postId: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case "/airlines":
        return MaterialPageRoute(
          builder: (_) => AirlinesPage(),
        );
      case "/passengers":
        return MaterialPageRoute(
          builder: (_) => const PassengersPage(),
        );
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
