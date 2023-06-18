import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/providers/firebase_auth_provider.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/screens/auth_widget_builder.dart';
import 'package:splitter/utils/get_provider.dart';

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
        ChangeNotifierProvider<DateTimeProvider>(
            create: (_) => DateTimeProvider()),
        ChangeNotifierProvider<UserProvider>(
          create: (_) => UserProvider(),
        ),
        Provider<FirebaseAuthProvider>(
          create: (_) => FirebaseAuthProvider(),
        ),
      ],
      builder: (context, _) => AuthWidgetBuilder(
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Poppins',
              // useMaterial3: true
            ),
            initialRoute: '/',
            onGenerateRoute:
                getProvider<FirebaseAuthProvider>(context).isUserSignedIn
                    ? RouteGenerator.signedInRoute
                    : RouteGenerator.signedOutRoute,
          );
        },
      ),
    );
  }
}
