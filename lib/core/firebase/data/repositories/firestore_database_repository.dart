import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/core/firebase/constants/collection_keys.dart';
import 'package:splittr/core/firebase/domain/repositories/i_firestore_database_repository.dart';
import 'package:splittr/core/user/data/dtos/user_dto.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

@Singleton(as: IFirestoreDatabaseRepository)
final class FirestoreDatabaseRepository
    implements IFirestoreDatabaseRepository {
  final FirebaseFirestore _firebaseFirestoreDb;

  final CollectionReference<Map<String, dynamic>> _userCollection;

  FirestoreDatabaseRepository(
    this._firebaseFirestoreDb,
  ) : _userCollection = _firebaseFirestoreDb
            .collection(FirebaseFirestoreCollectionKeys.users);

  @override
  FutureEitherFailureVoid saveUser(UserDto user) async {
    try {
      if (user.uid == null) {
        return left(const Failure(message: 'No uid present'));
      }
      await _userCollection
          .doc(user.uid)
          .set(user.toJson()..addAll(_timeStamps()));
      return right(unit);
    } catch (e) {
      return left(const Failure(message: 'Failed to save data'));
    }
  }

  Map<String, dynamic> _timeStamps() {
    return {
      ..._createdAtTimeStamp(),
      ..._updatedAtTimeStamp(),
    };
  }

  Map<String, dynamic> _createdAtTimeStamp() {
    return {
      'createdAt': FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> _updatedAtTimeStamp() {
    return {
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }
}
