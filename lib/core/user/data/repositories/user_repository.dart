import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
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
  FutureEitherFailure<User> updateUser(User user) async {
    final userDtoOrFailure =
        await _firestoreDatabaseRepository.updateUser(user.toDto());

    return userDtoOrFailure.fold(
      left,
      (userDto) => right(
        User.fromDto(userDto),
      ),
    );
  }

  @override
  FutureEitherFailure<User> fetchUser(String userId) async {
    final userDtoOrFailure =
        await _firestoreDatabaseRepository.fetchUser(userId);

    return userDtoOrFailure.fold(
      left,
      (userDto) => right(
        User.fromDto(userDto),
      ),
    );
  }

  @override
  Future<void> deleteUser(String userId) async {
    await _firestoreDatabaseRepository.deleteUser(userId);
  }
}
