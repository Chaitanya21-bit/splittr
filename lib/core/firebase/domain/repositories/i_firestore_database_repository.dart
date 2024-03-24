import 'package:splittr/core/user/data/dtos/user_dto.dart';
import 'package:splittr/utils/utils.dart';

abstract interface class IFirestoreDatabaseRepository {
  FutureEitherFailureVoid saveUser(UserDto user);

  FutureEitherFailure<UserDto> fetchUser(String uid);

  Future<void> deleteUser(String uid);
}
