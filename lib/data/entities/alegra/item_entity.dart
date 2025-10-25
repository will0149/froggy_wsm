import 'package:json_annotation/json_annotation.dart';

import 'inventory_entity.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */

part 'item_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemEntity {
  @JsonKey(name: 'id')
  String? id; //TODO: id de referencia dentro del ERP
  @JsonKey(name: 'name')
  String? name;
  @JsonKey(name: 'reference')
  String? reference; //propiedad con el sku reference
  @JsonKey(name: 'inventory')
  InventoryEntity? inventory;

  // @JsonKey(name: 'images')
  // List<Images>? images;

  ItemEntity(
      {this.id,
        this.name,
        this.reference,
        this.inventory});

  factory ItemEntity.fromJson(Map<String, dynamic> json)  => _$ItemEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ItemEntityToJson(this);
}