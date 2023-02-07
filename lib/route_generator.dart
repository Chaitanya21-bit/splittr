import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/main.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/auth_screens/signup_screen.dart';
import 'package:splitter/screens/drawer_screens/profile.dart';
import 'package:splitter/screens/drawer_screens/quick_split.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';
import 'dataclass/group.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while alling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case 'login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/grpDash':
        return MaterialPageRoute(
            builder: (_) =>
             GroupDashboard(group: args as Group)

            );
      case '/quickSplit':
        return MaterialPageRoute(
            builder: (_) => QuickSplit(
                  people: args as List<Map>,
                ));
      case '/profile':
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<Person>.value(
                  value: args as Person,
                  child: ProfileScreen(),
                ));

      case '/signUp':
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      default:
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
