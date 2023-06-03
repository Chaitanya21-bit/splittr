import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/user.dart';
import 'package:splitter/constants/routes.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/auth_screens/signup_screen.dart';
import 'package:splitter/screens/drawer_screens/profile.dart';
import 'package:splitter/screens/drawer_screens/quick_split.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';
import 'package:splitter/screens/main_dashboard.dart';
import 'dataclass/group.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {

    final args = settings.arguments;

    switch (settings.name) {
      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const MainDashboard());
      case Routes.grpDash:
        return MaterialPageRoute(
            builder: (_) =>
             GroupDashboard(group: args as Group)

            );
      case '/quickSplit':
        return MaterialPageRoute(
            builder: (_) => QuickSplit(
                  people: args as List<Map>,
                ));
      case Routes.profile:
        return MaterialPageRoute(
            builder: (_) => ChangeNotifierProvider<User>.value(
                  value: args as User,
                  child: const ProfileScreen(),
                ));

      case Routes.singUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
