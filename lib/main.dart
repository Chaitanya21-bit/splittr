import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
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
  Future<Person>? f() async {
    Person person = Person();
    final FirebaseAuth auth = FirebaseManager.auth;
    final FirebaseDatabase database = FirebaseManager.database;
    final userSnapshot =
        await database.ref().child('Users/${auth.currentUser!.uid}').get();
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(userSnapshot.value as Map<dynamic, dynamic>);

    final transactionsSnapshot = await database
        .ref()
        .child('Users/${auth.currentUser!.uid}/userTransactions')
        .get();
    if (transactionsSnapshot.exists) {
      final transactionsList = transactionsSnapshot.value as List;
      for (var transaction in transactionsList) {
        var snapshot =
            await database.ref().child('Transactions/$transaction').get();
        Map<String, dynamic> map =
            Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
        person.userTransactions.add(Transactions.fromJson(map));
      }
    }
    person.fromJson(userMap);
    return person;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
        future: f(),
        builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
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
