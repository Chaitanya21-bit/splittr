import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/constants/routes.dart';
import 'package:splitter/screens/auth_widget_builder.dart';
import 'package:splitter/services/services.dart';
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
                // useMaterial3: true
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
