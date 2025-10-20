import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable, JsonKey;

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/19/25
 */

part 'firesstore_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class FiresStoreEntity{
  @JsonKey(name: 'activate')
  bool? activate;

  FiresStoreEntity({this.activate});

  factory FiresStoreEntity.fromJson(Map<String, dynamic> json)  => _$FiresStoreEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FiresStoreEntityToJson(this);
}