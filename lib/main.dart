import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/screens/auth_screens/login_screen.dart';
import 'package:splitter/screens/main_dashboard.dart';
import 'auth/firebase_options.dart';
import 'auth/firebase_manager.dart';
import 'dataclass/group.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await checkUser();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
          create: (context) => Person()
      ),
    ],
    child:  MyApp(),
  ));
}

Future<void> checkUser() async {
  if (FirebaseManager.auth.currentUser != null) {
    final snapshot = await FirebaseManager.database
        .ref('Users/${FirebaseManager.auth.currentUser!.uid}')
        .get();

    if (!snapshot.exists) {
      await FirebaseManager.auth.signOut();
      Fluttertoast.showToast(
          msg: "^_^ You Got Deleted ^_^", toastLength: Toast.LENGTH_LONG);
    }
  }
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
            fontFamily: 'Poppins',
        ),
        initialRoute: 'login',
        onGenerateRoute: RouteGenerator.generateRoute,
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
      ),
      initialRoute: 'home',
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
    Person person = Provider.of<Person>(context,listen: false);
    await person.retrieveBasicInfo(FirebaseManager.auth.currentUser!.uid);
    await person.retrieveTransactions();
    await person.retrieveGroups();
    return person;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Person>(
        future: retrievePersonInfo(),
        builder: (BuildContext context, AsyncSnapshot<Person> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) { // Splash Screen
            return SizedBox(
                child: DecoratedBox(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Image.asset("assets/SplittrLogo.png")));
          } else if (snapshot.data == null) {
            Fluttertoast.showToast(msg: "User Not Found");
            return LoginScreen();
          }
          return  const MainDashboard()
          ;
        });
  }
}
