import 'package:splittr/core/user/data/dtos/user_dto.dart';
import 'package:splittr/core/user/domain/models/user.dart';
import 'package:splittr/utils/utils.dart';

abstract interface class IFirestoreDatabaseRepository {
  FutureEitherFailure<User> getUser(String userId);

  FutureEitherFailure<User> createUser(UserDto user);

  FutureEitherFailure<User> updateUser(UserDto user);

  FutureEitherFailureUnit deleteUser(String userId);
}
