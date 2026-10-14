import 'package:json_annotation/json_annotation.dart';

import '../../api_path_enums.dart';

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
  /// El API la manda como ruta relativa; aquí ya es absoluta.
  @JsonKey(name: 'avatar', fromJson: ApiPathsEnums.absoluteUrl)
  String? avatar;
  @JsonKey(name: 'bio')
  String? bio;
  @JsonKey(name: 'link')
  String? link;
  /// PERSON o COMMERCE.
  @JsonKey(name: 'user_type')
  String? userType;

  /// Puede crear eventos (los COMMERCE se verifican solos).
  @JsonKey(name: 'is_verified')
  bool? isVerified;

  /// Vacío, PROMOTION_MANAGER o ADMIN.
  @JsonKey(name: 'roles')
  List<String>? roles;

  UserProfileDTO(
      {this.username,
        this.email,
        this.firstName,
        this.lastName,
        this.avatar,
        this.bio,
        this.link,
        this.userType,
        this.isVerified,
        this.roles});

  factory UserProfileDTO.fromJson(Map<String, dynamic> json)  => _$UserProfileDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileDTOToJson(this);

}