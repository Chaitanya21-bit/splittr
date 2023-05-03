import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/person.dart';
import 'package:splitter/services/firebase_database_service.dart';
import 'package:splitter/services/personal_transaction_service.dart';
import '../services/firebase_auth_service.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder(
      {Key? key,
      required this.authService,
      required this.databaseService,
      required this.builder})
      : super(key: key);
  final Widget Function() builder;
  final FirebaseAuthService authService;
  final FirebaseDatabaseService databaseService;

  Future<Person?> getPerson(String uid) async {
    final json = await databaseService.get("Users/$uid");
    if (json == null) {
      await authService.signOut();
    }
    return json == null ? null : Person.fromJson(json);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authService.auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return SizedBox(
              child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image.asset("assets/SplittrLogo.png")));
        }
        if(snapshot.data == null){
          return builder();
        }
        Future<Person?> future = getPerson(authService.auth.currentUser!.uid);
        return FutureBuilder<Person?>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Image.asset("assets/SplittrLogo.png")));
              }
              if (snapshot.data == null) {
                return builder();
              }
              Person person = snapshot.data!;
              print(person);
              return MultiProvider(
                providers: [
                  ChangeNotifierProvider<Person>(create: (_) => person),
                  ChangeNotifierProvider<PersonalTransactionService>(
                      create: (_) => PersonalTransactionService()..fetchTransactions(person.personalTransactions))
                ],
                child: builder(),
              );
            });
      },);

  }
}
