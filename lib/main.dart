import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/constants/routes.dart';
import 'package:splitter/screens/auth_widget_builder.dart';
import 'package:splitter/services/datetime_service.dart';
import 'package:splitter/services/firebase_auth_service.dart';
import 'package:splitter/services/user_service.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DateTimeService>(create: (_) => DateTimeService()),
        ChangeNotifierProvider<UserService>(create: (_) => UserService()),
      ],
      child: AuthWidgetBuilder(
          builder: () {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
                fontFamily: 'Poppins',
              ),
              initialRoute: FirebaseAuthService.auth.currentUser == null
                  ? Routes.login
                  : Routes.home,
              onGenerateRoute: RouteGenerator.generateRoute,
            );
          }),
    );
  }
}
