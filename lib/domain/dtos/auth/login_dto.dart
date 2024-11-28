import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 11/16/24
 */
part 'login_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginDTO {
  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'password')
  String password;

  LoginDTO({required this.email, required this.password});

  factory LoginDTO.fromJson(Map<String, dynamic> json)  => _$LoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}