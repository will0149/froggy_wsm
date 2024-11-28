import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 11/28/24
 */

part 'auth_response_entity.g.dart';

@JsonSerializable(
    explicitToJson: true,
    ignoreUnannotated: true
)
class AuthResponseEntity {
  @JsonKey(name: 'accessToken')
  String? accessToken;
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'full_name')
  String? fullName;
  @JsonKey(name: 'roles')
  List<String>? roles;
  @JsonKey(name: 'permissions')
  List<String>? permissions;

  AuthResponseEntity(
      {this.accessToken, this.id, this.fullName, this.roles, this.permissions});

  factory AuthResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseEntityToJson(this);
}
