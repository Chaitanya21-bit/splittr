import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:splittr/core/user/data/dtos/user_dto.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    String? userId,
    String? name,
    String? phoneNo,
  }) = _User;

  const User._();

  factory User.fromDto(UserDto dto) {
    return User(
      userId: dto.userId,
      name: dto.name,
      phoneNo: dto.phoneNo,
    );
  }

  UserDto toDto() {
    return UserDto(
      userId: userId,
      name: name,
      phoneNo: phoneNo,
    );
  }
}
