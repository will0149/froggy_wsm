import 'package:json_annotation/json_annotation.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/17/25
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

  AuthResponseEntity(
      {this.token});

  factory AuthResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseEntityToJson(this);
}
