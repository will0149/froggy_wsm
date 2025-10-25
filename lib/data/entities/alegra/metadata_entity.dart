import 'package:json_annotation/json_annotation.dart';

import '../../../domain/convertes/int_converter.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/11/25
 */

part 'metadata_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class MetadataEntity {
  @IntConverter()
  @JsonKey(name: 'total')
  int? total;

  MetadataEntity({this.total});

  factory MetadataEntity.fromJson(Map<String, dynamic> json)  => _$MetadataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MetadataEntityToJson(this);
}