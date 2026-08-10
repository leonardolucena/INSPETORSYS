import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:inspetorsys/features/auth/data/dto/user_dto.dart';
import 'package:inspetorsys/features/auth/domain/entities/auth_token.dart';

part 'login_response_dto.freezed.dart';
part 'login_response_dto.g.dart';

@freezed
abstract class LoginResponseDto with _$LoginResponseDto {
  const factory LoginResponseDto({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'tokenType') String? tokenType,
    @JsonKey(name: 'expiresIn') int? expiresIn,
    required UserDto user,
  }) = _LoginResponseDto;

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDtoFromJson(json);
}

extension LoginResponseDtoMapper on LoginResponseDto {
  AuthToken toAuthToken() => AuthToken(value: accessToken);
}
