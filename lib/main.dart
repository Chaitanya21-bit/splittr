import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/route_generator.dart';
import 'package:splitter/screens/main_dashboard.dart';
import 'auth/firebase_options.dart';
import 'auth/firebase_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

Future<void> doSome() async {
  final snapshot = await database.ref("Group").get();
  if (snapshot.exists) {
    final l = snapshot.value;
    for (var group in snapshot.children) {
      final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
          uriPrefix: 'https://splittrflutter.page.link',
          link: Uri.parse(
              'https://splittrflutter.page.link.com/?id=${group.key}'),
          androidParameters: const AndroidParameters(
            packageName: 'com.example.splitter',
            minimumVersion: 1,
          ),
          iosParameters: const IOSParameters(bundleId: 'com.example.splitter'));
      final dynamicLink =
          await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
      await database
          .ref("Group/${group.key}/link")
          .set(dynamicLink.shortUrl.toString());
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
  Future<Uri> createDynamicLink(String id) async {
    final DynamicLinkParameters dynamicLinkParams = DynamicLinkParameters(
        uriPrefix: 'https://splittrflutter.page.link',
        link: Uri.parse('https://splittrflutter.page.link.com/?id=$id'),
        androidParameters: const AndroidParameters(
          packageName: 'com.example.splitter',
          minimumVersion: 1,
        ),
        iosParameters: const IOSParameters(bundleId: 'com.example.splitter'));
    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);
    return dynamicLink.shortUrl;
  }

  Future<String> retrieveDynamicLink() async {
    String gid = "";
    try {
      final PendingDynamicLinkData? data =
          await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = data?.link;

      if (deepLink != null) {
        print(" first $deepLink");
        gid = deepLink.queryParameters['id'].toString();
        Fluttertoast.showToast(msg: gid);
        return gid;
      }

      FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
        print("second $dynamicLinkData");
        gid = dynamicLinkData.link.queryParameters['id'].toString();
        print(gid);
        FirebaseDatabase database = FirebaseManager.database;
        FirebaseAuth auth = FirebaseManager.auth;
        var snapshot = await database
            .ref('Users/${auth.currentUser!.uid}/userGroups')
            .get();
        if (snapshot.exists) {
          final groupsList = snapshot.value as List;
          List<String> temp = List<String>.generate(
              groupsList.length, (index) => groupsList[index]);
          temp.add(gid);
          await database
              .ref('Users/${auth.currentUser!.uid}')
              .update({"userGroups": temp});
        }
      }).onError((error) {
        // Handle errors
      });
      return gid;
    } catch (e) {
      print(e.toString());
    }

    return gid;
  }

  Future<Person>? retrievePersonInfo() async {
    Person person = Person();
    var a = await retrieveDynamicLink();
    await person
        .retrieveBasicInfo(FirebaseManager.auth.currentUser!.uid.toString());
    await person.retrieveTransactions();
    await person.retrieveGroups();
    // Uri a = await createDynamicLink("33d3c010-6849-11ed-a1f8-c583cb2d99e5");
    print(a);
    // print(a);
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
