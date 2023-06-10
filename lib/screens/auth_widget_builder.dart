import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/dataclass/user.dart' as model;
import 'package:splitter/services/personal_transaction_service.dart';
import 'package:splitter/services/user_service.dart';

import '../services/firebase_auth_service.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function() builder;

  @override
  Widget build(BuildContext context) {
    final userService = Provider.of<UserService>(context, listen: false);
    return StreamBuilder<User?>(
      stream: FirebaseAuthService.auth.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> authUserSnapshot) {
        if (authUserSnapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image.asset("assets/SplittrLogo.png")));
        }
        if (authUserSnapshot.data == null) return builder();

        Future<model.User?> future =
            userService.retrieveUserInfo(authUserSnapshot.data!.uid);

        return FutureBuilder<model.User?>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                    child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.white),
                        child: Image.asset("assets/SplittrLogo.png")));
              }
              if (snapshot.data == null) return builder();

              model.User person = snapshot.data!;

              return MultiProvider(
                providers: [
                  ChangeNotifierProvider<PersonalTransactionService>(
                    create: (_) => PersonalTransactionService()..fetchTransactions(person.personalTransactions),
                  )
                ],
                child: builder(),
              );
            },);
      },
    );
  }
}
