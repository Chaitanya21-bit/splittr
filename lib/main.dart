import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/group.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/dataclass/transactions.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/screens/main_dashboard.dart';
import 'auth/firebase_options.dart';
import 'auth/firebase_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseManager();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final FirebaseAuth auth = FirebaseManager.auth;

  @override
  Widget build(BuildContext context) {
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
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Person>? retrievePersonInfo() async {
    Person person = Person();
    await person
        .retrieveBasicInfo(FirebaseManager.auth.currentUser!.uid.toString());
    await person.retrieveTransactions();
    await person.retrieveGroups();
    return person;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
        future: retrievePersonInfo(),
        builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
                child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Image.asset("assets/SplittrLogo.png")));
          }

          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (context) => snapshot.data as Person),
            ],
            child: const MainDashboard(),
          );
        });
  }
}
