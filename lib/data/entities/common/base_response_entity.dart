import 'package:json_annotation/json_annotation.dart';
import 'package:parkea/data/entities/common/status_entity.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 06/14/25
 */
part 'base_response_entity.g.dart';

@JsonSerializable(
    genericArgumentFactories: true,
    explicitToJson: true,
    ignoreUnannotated: true
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