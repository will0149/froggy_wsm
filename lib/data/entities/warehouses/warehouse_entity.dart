import 'package:json_annotation/json_annotation.dart';

import '../../../domain/convertes/bool_converter.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/22/24
 */
part 'warehouse_entity.g.dart';

@JsonSerializable(
    explicitToJson: true,
    ignoreUnannotated: true
)
class WarehouseEntity {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'barcode')
  String? barcode;
  @BoolConverter()
  @JsonKey(name: 'deleted')
  bool? deleted;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  WarehouseEntity(
      {this.name,
        this.description,
        this.barcode,
        this.deleted,
        this.deletedAt,
        this.createdAt,
        this.updatedAt});

  factory WarehouseEntity.fromJson(Map<String, dynamic> json) => _$WarehouseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseEntityToJson(this);
}