import 'package:cct_management/data/entities/status_entity.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer_entity.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 07/22/24
 */
part 'client_base_entity.g.dart';

@JsonSerializable(
    explicitToJson: true,
    ignoreUnannotated: true
)
class ClientBaseEntity {
  @JsonKey(name: 'body')
  final List<CustomerEntity>? body;
  @JsonKey(name: 'status')
  final StatusEntity? status;

  ClientBaseEntity({this.body, this.status});

  factory ClientBaseEntity.fromJson(
      Map<String, dynamic> json) =>
      _$ClientBaseEntityFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ClientBaseEntityToJson(this);
}