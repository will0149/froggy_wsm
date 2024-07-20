import 'package:cct_management/data/entities/status_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

part 'base_response_entity.g.dart';

@JsonSerializable(
  genericArgumentFactories: true, explicitToJson: true
)
class BaseResponseEntity<T> {
  @JsonKey(name: 'body')
  T? body;
  @JsonKey(name: 'status')
  StatusEntity? status;

  @JsonKey(name: 'insertedCount')
  int? insertedCount;

  BaseResponseEntity({this.body, this.status, this.insertedCount});

  factory BaseResponseEntity.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$BaseResponseEntityFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) =>
      _$BaseResponseEntityToJson(this, toJsonT);
}
