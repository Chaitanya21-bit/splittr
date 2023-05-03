import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/routes.dart';
import 'package:splitter/screens/auth_widget_builder.dart';
import 'package:splitter/services/datetime_service.dart';
import 'package:splitter/services/firebase_auth_service.dart';
import 'package:splitter/services/firebase_database_service.dart';
import 'package:splitter/size_config.dart';
import 'auth/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final authService = FirebaseAuthService();
    final databaseService = FirebaseDatabaseService();
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(create: (_) => authService),
        Provider<FirebaseDatabaseService>(create: (_) => databaseService),
        ChangeNotifierProvider<DateTimeService>(create: (_) => DateTimeService()),
      ],
      child: AuthWidgetBuilder(
          authService: authService,
          databaseService: databaseService,
          builder: () {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'Poppins',
              ),
              initialRoute: authService.auth.currentUser == null
                  ? Routes.login
                  : Routes.home,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }),
    );
  }
}
