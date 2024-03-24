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
}
