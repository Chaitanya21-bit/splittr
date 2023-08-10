import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:splitter/constants/typedefs.dart';
import 'package:splitter/dataclass/failure.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseAuth get auth => _auth;

  FutureEither<User> signUpWithEmail(String email, password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        throw "No credentials founds";
      }
      return right(credentials.user!);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e.code);
    } catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  FutureEither<User> signInWithEmail(
      {required String email, required String password}) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user == null) {
        throw "No credentials founds";
      }
      return right(credentials.user!);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthError(e.code);
    } catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
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
