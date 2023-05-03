import 'package:firebase_database/firebase_database.dart';

class FirebaseDatabaseService{
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  FirebaseDatabase get database => _database;

  Future<void> set(String path, Map<String, dynamic> data) async {
    await _database.ref(path).set(data);
  }
  Future<void> update(String path, Map<String, dynamic> data) async {
    await _database.ref(path).update(data);
  }

  Future<Map<String, dynamic>?> get(String path) async{
    final snapshot = await _database.ref(path).get();
    if(!snapshot.exists){
      return null;
    }
    return Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>);
  }

  remove(String path) async {
    await _database.ref(path).remove();
  }
}