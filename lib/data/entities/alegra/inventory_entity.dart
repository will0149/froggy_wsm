import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */

part 'inventory_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class InventoryEntity {
  @JsonKey(name: 'availableQuantity')
  int? availableQuantity;
  @JsonKey(name: 'initialQuantityDate')
  String? initialQuantityDate;
  InventoryEntity({this.availableQuantity, this.initialQuantityDate});

  factory InventoryEntity.fromJson(Map<String, dynamic> json)  => _$InventoryEntityFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryEntityToJson(this);
}