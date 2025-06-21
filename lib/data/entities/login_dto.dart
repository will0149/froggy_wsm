import 'package:json_annotation/json_annotation.dart';


/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/14/25
 */

part 'login_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class LoginDTO {

  @JsonKey(name: 'username')
  String? userName;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'password')
  String password;

  LoginDTO({this.userName, required this.email, required this.password});

  factory LoginDTO.fromJson(Map<String, dynamic> json)  => _$LoginDTOFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDTOToJson(this);
}