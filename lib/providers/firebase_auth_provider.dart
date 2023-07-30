import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:splitter/dataclass/dataclass.dart' as model;
import 'package:splitter/services/services.dart';

import '../constants/routes.dart';
import '../utils/toasts.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
  final _firebaseAuthService = FirebaseAuthService();
  final _userService = UserService();

  bool get isUserSignedIn => _auth.currentUser != null;

  User? get currentUser => _auth.currentUser;

  Future<void> signUpWithEmail(
    BuildContext context, {
    required String email,
    required String password,
    required String cnfPassword,
    required String name,
    required String alias,
  }) async {
    if (email.isEmpty) {
      return showToast("Enter email");
    }
    if (name.isEmpty) {
      return showToast("Enter name");
    }
    if (alias.isEmpty) {
      return showToast("Enter alias");
    }
    if (password.isEmpty) {
      return showToast("Enter password");
    }
    if (cnfPassword != password) {
      return showToast("Confirm password should be same as password");
    }
    try {
      final createdUser =
          await _firebaseAuthService.signUpWithEmail(email, password);
      final user = model.User(
        uid: createdUser!.uid,
        name: name,
        alias: alias,
        email: email,
        phoneNo: "28274",
        groups: [],
        personalTransactions: [],
        limit: -1,
      );
      await _userService.saveUserToDatabase(user);
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
            context, Routes.home, (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showToast(_handleAuthError(e.code));
    } catch (e) {
      Navigator.pop(context);
      showToast("An Error Occurred. ${e.toString()}");
    }
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
      showToast(_handleAuthError(e.code));
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

  String _handleAuthError(String code) {
    switch (code) {
      case 'email-already-in-use':
        return "Account already created.";
      case 'invalid-email':
        return "Invalid email.";
      case 'operation-not-allowed':
        return "Sign Up Not enabled.";
      case 'weak-password':
        return "Weak Password.";
      case 'user-not-found':
        return "No user found for this email.";
      case 'user-disabled':
        return "User is disabled.";
      case 'wrong-password':
        return "Wrong Password.";
      default:
        return "Failed to Sign Up.";
    }
  }
}
