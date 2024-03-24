import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/utils/utils.dart';

abstract interface class IUserRepository {
  FutureEitherFailureVoid saveUser(User user);

  FutureEitherFailure<User> fetchUser(String uid);

  Future<void> deleteUser(String uid);
}
