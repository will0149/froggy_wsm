import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 11/28/24
 */

part 'auth_response_entity.g.dart';

@JsonSerializable(
    explicitToJson: true,
    ignoreUnannotated: true
)
class AuthResponseEntity {
  @JsonKey(name: 'token')
  String? token;
  @JsonKey(name: 'refresh_token')
  String? refreshToken;
  @JsonKey(name: 'roles')
  List<String>? roles;
  @JsonKey(name: 'permissions')
  List<String>? permissions;

  AuthResponseEntity(
      {this.token, this.refreshToken, this.roles, this.permissions});

  factory AuthResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseEntityToJson(this);
}
