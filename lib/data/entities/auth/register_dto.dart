import 'package:json_annotation/json_annotation.dart';

part 'register_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RegisterDto {
  @JsonKey(name: 'username')
  String? username;
  @JsonKey(name: 'email')
  String? email;
  @JsonKey(name: 'password1')
  String? password1;
  @JsonKey(name: 'password2')
  String? password2;

  RegisterDto({this.username, this.email, this.password1, this.password2});

  factory RegisterDto.fromJson(Map<String, dynamic> json)  => _$RegisterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterDtoToJson(this);

}

