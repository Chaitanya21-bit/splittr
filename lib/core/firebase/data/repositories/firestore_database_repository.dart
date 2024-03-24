import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/constants/constants.dart';
import 'package:splittr/constants/string_constants/string_constants.dart';
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
      if (user.userId == null) {
        return left(const Failure(message: 'No userId present'));
      }
      await _userCollection
          .doc(user.userId)
          .set(user.toJson()..addAll(_timeStamps()));
      return right(unit);
    } catch (e) {
      return left(const Failure(message: 'Failed to save data'));
    }
  }

  @override
  FutureEitherFailure<UserDto> updateUser(UserDto user) async {
    try {
      if (user.userId == null) {
        return left(const Failure(message: 'No userId present'));
      }
      await _userCollection
          .doc(user.userId)
          .update(user.toJson()..addAll(_updatedAtTimeStamp()));
      return right(user);
    } catch (e) {
      return left(const Failure(message: 'Failed to update data'));
    }
  }

  @override
  FutureEitherFailure<UserDto> fetchUser(String userId) async {
    try {
      final snapshot = await _userCollection.doc(userId).get();

      final json = snapshot.data();

      if (json != null && json.isNotEmpty) {
        if (json.containsKey(StringConstants.createdAt)) {
          json[StringConstants.createdAt] =
              (json[StringConstants.createdAt] as Timestamp)
                  .toDate()
                  .toIso8601String();
        }

        if (json.containsKey(StringConstants.updatedAt)) {
          json[StringConstants.updatedAt] =
              (json[StringConstants.updatedAt] as Timestamp)
                  .toDate()
                  .toIso8601String();
        }

        return right(UserDto.fromJson(json));
      }

      return left(const Failure(message: 'User Not Found'));
    } catch (_) {
      return left(const Failure(message: 'Failed to fetch user'));
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
    try {
      await _userCollection.doc(userId).delete();
    } catch (_) {}
  }

  Map<String, dynamic> _timeStamps() {
    return {
      ..._createdAtTimeStamp(),
      ..._updatedAtTimeStamp(),
    };
  }

  Map<String, dynamic> _createdAtTimeStamp() {
    return {
      StringConstants.createdAt: FieldValue.serverTimestamp(),
    };
  }

  Map<String, dynamic> _updatedAtTimeStamp() {
    return {
      StringConstants.updatedAt: FieldValue.serverTimestamp(),
    };
  }
}
