import 'package:injectable/injectable.dart';
import 'package:splittr/core/auth/domain/repositories/i_auth_repository.dart';
import 'package:splittr/core/firebase/domain/repositories/i_firestore_database_repository.dart';
import 'package:splittr/core/user/domain/domain/repositories/i_user_repository.dart';
import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/utils/typedefs/typedefs.dart';

@Singleton(as: IUserRepository)
final class UserRepository implements IUserRepository {
  final IFirestoreDatabaseRepository _firestoreDatabaseRepository;
  final IAuthRepository _authRepository;

  UserRepository(this._firestoreDatabaseRepository, this._authRepository);

  @override
  FutureEitherFailure<User> getUser() async {
    return _firestoreDatabaseRepository.getUser(_authRepository.userId ?? '');
  }

  @override
  FutureEitherFailure<User> createUser(User user) async {
    return _firestoreDatabaseRepository.createUser(user.toDto());
  }

  @override
  FutureEitherFailure<User> updateUser(User user) async {
    return _firestoreDatabaseRepository.updateUser(user.toDto());
  }

  @override
  FutureEitherFailureUnit deleteUser() async {
    return _firestoreDatabaseRepository.deleteUser(
      _authRepository.userId ?? '',
    );
  }
}
