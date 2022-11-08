import 'package:flutter/material.dart';
import 'package:splitter/main.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments.toString();

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/grpDash':
        return MaterialPageRoute(builder: (_) => GroupDashboard(data: args));

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