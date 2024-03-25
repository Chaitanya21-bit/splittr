import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/utils/utils.dart';

abstract interface class IUserRepository {
  FutureEitherFailure<User> saveUser(User user);

  FutureEitherFailure<User> updateUser(User user);

  FutureEitherFailure<User> fetchUser(String userId);

  Future<void> deleteUser(String userId);
}
