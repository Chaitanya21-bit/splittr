import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/providers/providers.dart';
import 'package:splitter/route_generator.dart';

import 'auth/firebase_options.dart';
import 'components/dialogs/join_group_dialog.dart';
import 'constants/routes.dart';

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
        ChangeNotifierProvider(create: (_) => DateTimeProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        Provider(create: (_) => FirebaseAuthProvider()),
        Provider(create: (context) => DynamicLinksProvider(context)),
        ChangeNotifierProvider(create: (_) => PersonalTransactionProvider()),
        ChangeNotifierProvider(create: (_) => GroupProvider()),
        ChangeNotifierProvider(create: (context) => JoinGroupProvider(context)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins',
          // useMaterial3: true
        ),
        initialRoute: Routes.splash,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
