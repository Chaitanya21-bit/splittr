import 'package:flutter/material.dart';
import 'package:splittr/core/route_handler/route_handler.dart';
import 'package:splittr/core/route_handler/route_observer.dart';
import 'package:splittr/di/injection.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splittr',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteId.splash.name,
      onGenerateRoute: RouteHandler.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      navigatorObservers: [
        CustomNavigatorObserver(),
      ],
    );
  }
}
