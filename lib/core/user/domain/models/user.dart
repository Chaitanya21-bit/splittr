import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splittr/core/user/data/dtos/user_dto.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    String? name,
    String? uid,
    String? phoneNo,
  }) = _User;

  const User._();

  static User? fromDto(UserDto? dto) {
    if (dto == null) {
      return null;
    }
    return User(
      uid: dto.uid,
      name: dto.name,
      phoneNo: dto.phoneNo,
    );
  }

  UserDto toDto() {
    return UserDto(
      uid: uid,
      name: name,
      phoneNo: phoneNo,
    );
  }
}
