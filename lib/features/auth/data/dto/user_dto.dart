import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/auth/domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
abstract class UserDto with _$UserDto {
  const factory UserDto({
    required String id,
    required String name,
    required String email,
    String? role,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}

extension UserDtoMapper on UserDto {
  User toDomain() {
    return User(
      id: id,
      name: name,
      email: email,
      role: role,
    );
  }
}
