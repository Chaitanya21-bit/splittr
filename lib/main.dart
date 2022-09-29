import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:splitter/dataclass/person.dart';
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
        home: LoginScreen(),
      );
    }
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LoggedIn',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
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
    return Scaffold(
      appBar: AppBar(
        title: Text("MAIN.dart", style: TextStyle()),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseManager.auth.signOut();
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MainDashboard()))
                    },
                child: const Text("Main Dashboard")),
            TextButton(
                onPressed: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => GroupDashboard()))
                    },
                child: const Text("Group Dashboard")),
            ElevatedButton(
              onPressed: () async {
                await joinGroup(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("Join Group"),
            ),
            ElevatedButton(
              onPressed: () async {
                await newGroup(context);
              },
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xff42a5f5)),
                // backgroundColor: MaterialStateProperty.all(const Color(0xff1870B5)),
                overlayColor: MaterialStateProperty.all<Color>(Colors.pink),
              ),
              child: const Text("New Group"),
            ),
          ],
        ),
      ),
      drawer: const NavigationDrawerWidget(),
    );
  }
}
