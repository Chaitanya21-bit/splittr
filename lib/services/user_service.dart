import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:splitter/constants/firebase_endpoints.dart';
import 'package:splitter/constants/typedefs.dart';
import 'package:splitter/dataclass/dataclass.dart';
import 'package:splitter/dataclass/failure.dart';

class UserService {
  final _database = FirebaseFirestore.instance;

  FutureEither<bool> saveUserToDatabase(User user) async {
    try {
      await _database.collection(usersCollection).doc(user.uid).set(user.toJson());
      return right(true);

    } on Exception catch (e) {
      return left(Failure(msg: e.toString()));
    }
  }

  Future<User?> getUserFromDatabase(String uid) async {
    final snapshot = await _database.collection(usersCollection).doc(uid).get();
    return snapshot.exists ? User.fromJson(snapshot.data()!) : null;
  }

  updateUserToDatabase(User user) async {
    await _database.collection(usersCollection).doc(user.uid).update(user.toJson());
  }
}