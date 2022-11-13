import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/main.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/drawer_screens/quick_split.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';
import 'package:splitter/screens/main_dashboard.dart';

import 'auth/firebase_manager.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while alling Navigator.pushNamed
    final args = settings.arguments.toString();

    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/grpDash':
        return MaterialPageRoute(builder: (_) => GroupDashboard(data: args));
      case '/quickSplit':
        return MaterialPageRoute(
            builder: (_) => const QuickSplit(
                  people: {},
                ));
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
