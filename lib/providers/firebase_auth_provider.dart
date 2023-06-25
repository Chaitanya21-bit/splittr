import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter/dataclass/user.dart' as model;
import 'package:splitter/services/firebase_auth_service.dart';

import '../utils/toasts.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
  final _firebaseAuthService = FirebaseAuthService();

  bool get isUserSignedIn => _auth.currentUser != null;

  Future<void> signUpWithEmail(
      {required String email,
      required String password,
      required String cnfPassword,
      required String name,
      required String alias}) async {
    if(email.isEmpty){
      return showToast("Enter email");
    }
    if(name.isEmpty){
      return showToast("Enter name");
    }
    if(alias.isEmpty){
      return showToast("Enter alias");
    }
    if(password.isEmpty){
      return showToast("Enter password");
    }
    if(cnfPassword != password){
      return showToast("Confirm password should be same as password");
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final user = model.User(
          uid: "",
          name: name,
          alias: alias,
          email: email,
          phoneNo: "28274",
          groups: [],
          personalTransactions: [],
          limit: -1);

      await prefs.setString('userMap', jsonEncode(user.toJson()));
      await _firebaseAuthService.signUpWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
      await prefs.remove('userMap');
      String errorMsg = "";
      switch (e.code) {
        case 'email-already-in-use':
          errorMsg = "Account already created.";
          break;
        case 'invalid-email':
          errorMsg = "Invalid email.";
          break;
        case 'operation-not-allowed':
          errorMsg = "Sign Up Not enabled.";
          break;
        case 'weak-password':
          errorMsg = "Weak Password.";
          break;
        default:
          errorMsg = "Failed to Sign Up.";
      }
      showToast(errorMsg);
    } catch (e) {
      await prefs.remove('userMap');
      showToast("An Error Occurred.");
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    if (email.isEmpty) {
      return showToast("Enter email");
    }
    if (password.isEmpty) {
      return showToast("Enter password");
    }
    try {
      await _firebaseAuthService.signInWithEmail(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMsg = "";
      switch (e.code) {
        case 'invalid-email':
          errorMsg = "Invalid email.";
          break;
        case 'user-not-found':
          errorMsg = "No user found for this email.";
          break;
        case 'user-disabled':
          errorMsg = "User is disabled.";
          break;
        case 'wrong-password':
          errorMsg = "Wrong Password.";
          break;
        default:
          errorMsg = "Failed to Login.";
      }
      showToast(errorMsg);
    } catch (e) {
      showToast("An Error Occurred.");
    }
  }

  Future<void> signOut() async {
    return _firebaseAuthService.signOut();
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuthService.auth.authStateChanges();
  }
}
