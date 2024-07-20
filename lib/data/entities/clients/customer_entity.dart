import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cctmanagement.
 * By User: josedominguez
 * Date: 06/16/24
 */

part 'customer_entity.g.dart';

@JsonSerializable()
class CustomerEntity {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'barcode')
  String? barcode;
  @JsonKey(name: 'deleted')
  bool? deleted;
  @JsonKey(name: 'deletedAt')
  String? deletedAt;
  @JsonKey(name: 'createdAt')
  String? createdAt;
  @JsonKey(name: 'updatedAt')
  String? updatedAt;

  CustomerEntity(
      {int? id,
        String? name,
        String? description,
        String? barcode,
        bool? deleted,
        String? deletedAt,
        String? createdAt,
        String? updatedAt});

  factory CustomerEntity.fromJson(Map<String, dynamic> json) => _$CustomerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerEntityToJson(this);
}