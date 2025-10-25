import 'package:froggy_soft/data/entities/alegra/item_entity.dart';
import 'package:froggy_soft/data/entities/alegra/metadata_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */
part 'items_list_response_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class ItemsListResponseEntity {
  MetadataEntity? metadata;
  List<ItemEntity>? data;

  ItemsListResponseEntity({this.metadata, this.data});

  factory ItemsListResponseEntity.fromJson(Map<String, dynamic> json)  => _$ItemsListResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ItemsListResponseEntityToJson(this);
}
