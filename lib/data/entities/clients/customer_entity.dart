import 'package:json_annotation/json_annotation.dart';


/**
 * Made for cctmanagement.
 * By User: josedominguez
 * Date: 06/16/24
 */

part 'customer_entity.g.dart';

@JsonSerializable(
    explicitToJson: true,
    ignoreUnannotated: true
)
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
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  CustomerEntity(
      {this.name,
        this.description,
        this.barcode,
        this.deleted,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  factory CustomerEntity.fromJson(Map<String, dynamic> json) => _$CustomerEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerEntityToJson(this);
}