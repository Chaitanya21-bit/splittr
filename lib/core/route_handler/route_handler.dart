import 'package:flutter/material.dart';
import 'package:splittr/core/route_handler/route_id.dart';
import 'package:splittr/features/splash/presentation/ui/splash_page.dart';
import 'package:splittr/utils/extensions/enum_extensions.dart';

export 'route_id.dart';

class RouteHandler {
  const RouteHandler._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final routeId = RouteId.values.fromString(settings.name);

    if (routeId == null) {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('ERROR'),
          ),
        ),
      );
    }

    final args = settings.arguments as Map<String, dynamic>?;

    return MaterialPageRoute(
      settings: settings,
      builder: (_) => switch (routeId) {
        RouteId.splash => SplashPage(args: args),
        _ => SplashPage(args: args),
        // RouteId.dashboard => DashboardScreen(args: args),
        // RouteId.login => DashboardScreen(args: args),
        // RouteId.signup => DashboardScreen(args: args),
        // RouteId.profile => DashboardScreen(args: args),
        // RouteId.groupDashboard => DashboardScreen(args: args),
        // RouteId.quickSettle => DashboardScreen(args: args),
        // RouteId.quickSplit => DashboardScreen(args: args),
      },
    );
  }

  static Future<Map<String, dynamic>?> push(
    BuildContext context,
    RouteId routeId, {
    Map<String, dynamic>? args,
  }) async {
    final returnedArgs = await Navigator.pushNamed(
      context,
      routeId.name,
      arguments: args,
    );
    return returnedArgs as Map<String, dynamic>?;
  }

  static Future<Map<String, dynamic>?> pushReplacement(
    BuildContext context,
    RouteId routeId, {
    Map<String, dynamic>? args,
  }) async {
    final returnedArgs = await Navigator.pushReplacementNamed(
      context,
      routeId.name,
      arguments: args,
    );
    return returnedArgs as Map<String, dynamic>?;
  }

  static Future<Map<String, dynamic>?> pushAndRemoveUntil(
    BuildContext context,
    RouteId routeId,
    bool Function(Route<dynamic>) predicate, {
    Map<String, dynamic>? args,
  }) async {
    final returnedArgs = await Navigator.pushNamedAndRemoveUntil(
      context,
      routeId.name,
      predicate,
      arguments: args,
    );
    return returnedArgs as Map<String, dynamic>?;
  }
}
