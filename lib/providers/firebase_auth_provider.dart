import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/dataclass.dart' as model;
import 'package:splitter/dataclass/failure.dart';
import 'package:splitter/services/services.dart';
import 'package:splitter/utils/auth_utils.dart';

import '../constants/routes.dart';
import '../utils/toasts.dart';

class FirebaseAuthProvider {
  final _firebaseAuthService = FirebaseAuthService();
  final _userService = UserService();

  FirebaseAuth get auth => _firebaseAuthService.auth;

  bool get isUserSignedIn => auth.currentUser != null;

  User? get currentUser => auth.currentUser;

  Future<void> signUpWithEmail(
    BuildContext context, {
    required String email,
    required String password,
    required String cnfPassword,
    required String name,
    required String alias,
  }) async {
    showLoadingDialog(context);
    final result = await _firebaseAuthService.signUpWithEmail(email, password);
    result.fold(
      (failure) => _handleFailure(failure, context),
      (user) async {
        final model.User userModel = model.User(
          uid: user.uid,
          name: name,
          alias: alias,
          email: email,
          phoneNo: "289",
          groups: [],
          personalTransactions: [],
          limit: -1,
        );
        showLoadingDialog(context);
        final result = await _userService.saveUserToDatabase(userModel);
        result.fold(
          (failure) => _handleFailure(failure, context),
          (success) => Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.splash,
            (route) => false,
          ),
        );
      },
    );
  }

  void _handleFailure(Failure failure, BuildContext context) {
    Navigator.pop(context);
    showToast(failure.msg);
  }

  Future<void> signInWithEmail(BuildContext context,
      {required String email, required String password}) async {
    if (email.isEmpty) {
      return showToast("Enter email");
    }
    if (password.isEmpty) {
      return showToast("Enter password");
    }
    try {
      final user = await _firebaseAuthService.signInWithEmail(
          email: email, password: password);
      if (context.mounted && user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      // showToast(_handleAuthError(e.code));
    } catch (e) {
      Navigator.pop(context);
      showToast("An Error Occurred.");
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _firebaseAuthService.signOut();
    if (context.mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, Routes.login, (route) => false);
    }
  }
}
