import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/22/25
 */
part 'user_profile_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class UserProfileDTO {
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'first_name')
  String? firstName;
  @JsonKey(name: 'last_name')
  String? lastName;
  @JsonKey(name: 'avatar')
  String? avatar;
  @JsonKey(name: 'bio')
  String? bio;
  @JsonKey(name: 'link')
  String? link;
  @JsonKey(name: 'userType')
  int? userType;

  UserProfileDTO(
      {this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.avatar,
        this.bio,
        this.link,
        this.userType});

  factory UserProfileDTO.fromJson(Map<String, dynamic> json)  => _$UserProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDTOToJson(this);

}