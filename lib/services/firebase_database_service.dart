import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService{
  static final FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<void> set(String path, Map<String, dynamic> data) async {
    await database.ref(path).set(data);
  }
  static Future<void> update(String path, Map<String, dynamic> data) async {
    await database.ref(path).update(data);
  }

  static Future<Map<String, dynamic>?> get(String path) async{
    final snapshot = await database.ref(path).get();
    return !snapshot.exists ? null : Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
  }

  static remove(String path) async {
    await database.ref(path).remove();
  }
}