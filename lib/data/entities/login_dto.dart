import 'package:json_annotation/json_annotation.dart';


/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/14/25
 */

part 'login_dto.g.dart';

/// El API acepta `username` o `email` junto con `password`.
@JsonSerializable(explicitToJson: true)
class LoginDTO {

  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'email')
  String? email;

  @JsonKey(name: 'password')
  String password;

  LoginDTO({this.username, this.email, required this.password});

  /// Envía [identifier] como email si contiene '@', si no como username.
  factory LoginDTO.fromIdentifier(String identifier, String password) {
    final value = identifier.trim();
    return value.contains('@')
        ? LoginDTO(email: value, password: password)
        : LoginDTO(username: value, password: password);
  }

  factory LoginDTO.fromJson(Map<String, dynamic> json)  => _$LoginDTOFromJson(json);

  /// Sin nulos: si llegara `"email": null` el API lo trataría como email.
  Map<String, dynamic> toJson() =>
      _$LoginDTOToJson(this)..removeWhere((_, value) => value == null);
}