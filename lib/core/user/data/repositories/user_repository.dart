import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:splittr/core/failure/failure.dart';
import 'package:splittr/core/firebase/domain/repositories/i_firestore_database_repository.dart';
import 'package:splittr/core/user/domain/domain/repositories/i_user_repository.dart';
import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

@Singleton(as: IUserRepository)
final class UserRepository implements IUserRepository {
  final IFirestoreDatabaseRepository _firestoreDatabaseRepository;

  UserRepository(
    this._firestoreDatabaseRepository,
  );

  @override
  FutureEitherFailureVoid saveUser(User user) {
    return _firestoreDatabaseRepository.saveUser(user.toDto());
  }

  @override
  FutureEitherFailure<User> fetchUser(String uid) async {
    final userDtoOrFailure = await _firestoreDatabaseRepository.fetchUser(uid);

    return userDtoOrFailure.fold(
      left,
      (userDto) {
        final user = User.fromDto(userDto);
        if (user == null) {
          return left(const Failure(message: 'User Not found'));
        }
        return right(user);
      },
    );
  }

  @override
  Future<void> deleteUser(String uid) async {
    await _firestoreDatabaseRepository.deleteUser(uid);
  }
}
