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
        final state = Navigator.of(context);
        final groupProvider =
            getProvider<GroupProvider>(context, listen: false);
        final personalTransactionProvider =
            getProvider<PersonalTransactionProvider>(context, listen: false);
        if (authProvider.isUserSignedIn) {
          final uid = authProvider.currentUser!.uid;
          final user = await userProvider.retrieveUserInfo(uid);

          if (user == null) {
            state.pushReplacementNamed(Routes.login);
            return;
          }
          if (context.mounted) {
            groupProvider.init(context);
            personalTransactionProvider.init(context);
          }
          state.pushReplacementNamed(Routes.home);
        } else {
          state.pushReplacementNamed(Routes.login);
        }
      },
    );
  }
}
