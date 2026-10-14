// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileDTO _$UserProfileDTOFromJson(Map<String, dynamic> json) =>
    UserProfileDTO(
      username: json['username'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      avatar: ApiPathsEnums.absoluteUrl(json['avatar'] as String?),
      bio: json['bio'] as String?,
      link: json['link'] as String?,
      userType: json['user_type'] as String?,
      isVerified: json['is_verified'] as bool?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$UserProfileDTOToJson(UserProfileDTO instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'link': instance.link,
      'user_type': instance.userType,
      'is_verified': instance.isVerified,
      'roles': instance.roles,
    };
