import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/dtos/series_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 08/13/24
 */
part 'body_stocks_entity.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class BodyStocksEntity{

  @JsonKey(name: 'cartonid')
  String? cartonid;

  @JsonKey(name: 'location')
  String? location;

  @JsonKey(name: 'warehouse')
  String? warehouse;
  @JsonKey(name: 'serie')
  String? serie;


  BodyStocksEntity({this.cartonid, this.location, this.warehouse, this.serie, });

  factory BodyStocksEntity.fromJson(Map<String, dynamic> json)  => _$BodyStocksEntityFromJson(json);

  Map<String, dynamic> toJson() => _$BodyStocksEntityToJson(this);
}