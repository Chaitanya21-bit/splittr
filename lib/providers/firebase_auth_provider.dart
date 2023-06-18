import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splitter/dataclass/user.dart' as model;
import 'package:splitter/services/firebase_auth_service.dart';

class FirebaseAuthProvider {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;
  final _firebaseAuthService = FirebaseAuthService();

  bool get isUserSignedIn => _auth.currentUser != null;

  Future<void> signUpWithEmail(String email, password, model.User user) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userMap', jsonEncode(user.toJson()));
      await _firebaseAuthService.signUpWithEmail(email, password);
    } on FirebaseAuthException catch (e) {
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
      Fluttertoast.showToast(msg: errorMsg);
    } catch (e) {
      Fluttertoast.showToast(msg: "An Error Occurred.");
    }
  }

  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    try {
      await _firebaseAuthService.signInWithEmail(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMsg = "";
      switch (e.code) {
        case 'user-not-found':
          errorMsg = "No user found for this email.";
          break;
        case 'invalid-email':
          errorMsg = "Invalid email.";
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
      Fluttertoast.showToast(msg: errorMsg);
    } catch (e) {
      Fluttertoast.showToast(msg: "An Error Occurred.");
    }
  }

  Future<void> signOut() async {
    return _firebaseAuthService.signOut();
  }

  Stream<User?> authStateChanges() {
    return _firebaseAuthService.auth.authStateChanges();
  }
}
