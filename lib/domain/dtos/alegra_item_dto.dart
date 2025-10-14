import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/13/25
 */

part 'alegra_item_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class AlegraItemDto {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'reference')
  String? reference;

  @JsonKey(name: 'quantity')
  int? quantity;

  @JsonKey(name: 'qty_difference')
  int? qtyDifference;

  @JsonKey(name: 'last_compare')
  String? lastCompare;

  @JsonKey(name: 'created_at')
  String? createdAt;

  @JsonKey(name: 'updated_at')
  String? updatedAt;

  AlegraItemDto({
    this.id,
    this.name,
    this.reference,
    this.quantity,
    this.qtyDifference,
    this.lastCompare,
    this.createdAt,
    this.updatedAt,
  });

  factory AlegraItemDto.fromJson(Map<String, dynamic> json) =>
      _$AlegraItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AlegraItemDtoToJson(this);
}