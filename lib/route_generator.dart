import 'package:flutter/material.dart';
import 'package:posts_clean_arch/fearutres/posts/presentation/pages/posts_page.dart';
import 'package:posts_clean_arch/fearutres/users/presentation/pages/users_page.dart';
import 'package:posts_clean_arch/main.dart';

import 'fearutres/Kyc/presentation/pages/kyc_page.dart';
import 'fearutres/airlines/presentation/pages/airlines_page.dart';
import 'fearutres/passengers/presentation/pages/passengers_page.dart';

class RouteHelper {
  static animatedPage(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/users':
        // Validation of correct data type
        return RouteHelper.animatedPage(const UsersPage());
      case '/comments':
        // Validation of correct data type
        if (args is int) {
          return RouteHelper.animatedPage(CommentsPage(postId: args));
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case "/airlines":
        return RouteHelper.animatedPage(const AirlinesPage());
      case "/passengers":
        return RouteHelper.animatedPage(const PassengersPage());
      case "/KYC":
        return RouteHelper.animatedPage(const KycPage());
      case "/FinalKYC":
        return RouteHelper.animatedPage(const FinalKycPage());
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
