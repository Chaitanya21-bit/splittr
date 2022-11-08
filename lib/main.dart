import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/group_screens/group_dashboard.dart';
import 'package:splitter/screens/main_dashboard.dart';
import 'package:splitter/screens/popup_screens/join_group_popup.dart';
import 'package:splitter/screens/popup_screens/new_group_popup.dart';
import 'package:splitter/widgets/navigation_drawer.dart';
import 'auth/firebase_options.dart';
import 'auth/firebase_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseManager.auth;

    if (auth.currentUser == null) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

        initialRoute: '/login',
        onGenerateRoute: RouteGenerator.generateRoute,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'splittr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseDatabase database = FirebaseManager.database;
  FirebaseAuth auth = FirebaseManager.auth;
  late final Person person;
  @override
  void initState() {
    super.initState();
  }

  Future<void> setPerson() async {
    final snapshot =
        await database.ref().child('Users/${auth.currentUser!.uid}').get();
    if (snapshot.exists) {
      // person = Person.fromJson(snapshot.value as Map<String, dynamic>);
      print(snapshot.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    setPerson();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'splittr',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainDashboard(),
    );
  }
}
