import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseManager {
  static late FirebaseAuth auth;
  static late FirebaseDatabase database;

  FirebaseManager() {
    FirebaseManager.auth = FirebaseAuth.instance;
    FirebaseManager.database = FirebaseDatabase.instance;
  }
}
