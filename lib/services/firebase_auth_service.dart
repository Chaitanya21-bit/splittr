import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseAuthService {
  static final FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User?> signUp(String email, password) async {
    try {
      final credentials = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credentials.user;
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
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: "An Error Occurred.");
      return null;
    }
  }

  static Future<User?> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
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

  static Future<void> signOut() async {
    await auth.signOut();
  }

  static Stream<User?> authStateChanges(){
    return auth.authStateChanges();
  }
}
