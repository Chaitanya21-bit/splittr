import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/utils/utils.dart';

abstract interface class IUserRepository {
  FutureEitherFailure<User> getUser();

  FutureEitherFailure<User> createUser(User user);

  FutureEitherFailure<User> updateUser(User user);

  FutureEitherFailureUnit deleteUser();
}
