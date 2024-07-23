import 'package:json_annotation/json_annotation.dart';

import '../../device/utils/logger_config.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

part 'base_data_entity.g.dart';

@JsonSerializable(
  genericArgumentFactories: true, explicitToJson: true,
    constructor: '_'
)
class BaseDataEntity<T> {
  @JsonKey(name: 'data')
  T? data;

  BaseDataEntity({this.data});

  BaseDataEntity._(this.data);

  factory BaseDataEntity.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseDataEntityFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$BaseDataEntityToJson(this, toJsonT);
}
