import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  Future<User?> signUpWithEmail(String email, password) async {
    final credentials = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return credentials.user;
  }

  Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
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
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: "An Error Occurred.");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
