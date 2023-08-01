import 'package:flutter/cupertino.dart';
import 'package:splitter/constants/routes.dart';
import 'package:splitter/providers/group_provider.dart';
import 'package:splitter/providers/personal_transaction_provider.dart';

import '../../providers/firebase_auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/get_provider.dart';

class SplashScreenController extends ChangeNotifier {
  final BuildContext context;
  late final UserProvider userProvider;
  late final FirebaseAuthProvider authProvider;

  SplashScreenController(this.context) {
    userProvider = getProvider<UserProvider>(context);
    authProvider = getProvider<FirebaseAuthProvider>(context);
    init();
  }

  void init() {
    Future.delayed(
      const Duration(seconds: 2),
      () async {
        if (authProvider.isUserSignedIn) {
          final uid = authProvider.currentUser!.uid;
          final user = await userProvider.retrieveUserInfo(uid);
          if (context.mounted) {
            getProvider<GroupProvider>(context, listen: false).init(context);
            getProvider<PersonalTransactionProvider>(context, listen: false)
                .init(context);
            Navigator.pushReplacementNamed(
              context,
              user == null ? Routes.login : Routes.home,
            );
          }
          return;
        }
        Navigator.pushReplacementNamed(context, Routes.login);
      },
    );
  }
}
