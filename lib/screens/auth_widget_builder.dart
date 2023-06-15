import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splitter/components/dialogs/dialogs.dart';
import 'package:splitter/dataclass/user.dart' as model;
import 'package:splitter/providers/providers.dart';

import '../utils/get_provider.dart';

class AuthWidgetBuilder extends StatelessWidget {
  const AuthWidgetBuilder({Key? key, required this.builder}) : super(key: key);
  final Widget Function() builder;

  @override
  Widget build(BuildContext context) {
    final userProvider = getProvider<UserProvider>(context);
    return StreamBuilder<User?>(
      stream: userProvider.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> authUserSnapshot) {
        if (authUserSnapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
              child: DecoratedBox(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Image.asset("assets/SplittrLogo.png")));
        }
        if (authUserSnapshot.data == null) return builder();

        Future<model.User?> future = userProvider.retrieveUserInfo();

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
            debugPrint("User Retrieved");
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<PersonalTransactionProvider>(
                  create: (_) => PersonalTransactionProvider(userProvider)
                    ..fetchTransactions(),
                ),
                ChangeNotifierProvider<GroupProvider>(
                  create: (_) => GroupProvider(userProvider)..fetchGroups(),
                ),
                ChangeNotifierProvider<JoinGroupProvider>(
                  create: (context) => JoinGroupProvider(context),
                ),
              ],
              child: builder(),
            );
          },
        );
      },
    );
  }
}
