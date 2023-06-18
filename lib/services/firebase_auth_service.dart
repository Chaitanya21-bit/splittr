import 'package:firebase_auth/firebase_auth.dart';

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
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }
}
