import 'package:cct_management/domain/dtos/series_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'dimensions_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

part 'inbound_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class InboundDto {
  @JsonKey(name: 'docnum')
  String? docnum;
  @JsonKey(name: 'device')
  String? device;
  @JsonKey(name: 'branch')
  String? branch;
  @JsonKey(name: 'asset')
  String? asset;
  @JsonKey(name: 'user')
  String? user;
  @JsonKey(name: 'cartonid')
  String? cartonId;
  @JsonKey(name: 'customer')
  String? customer;
  @JsonKey(name: 'warehouse')
  String? warehouse;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'batch')
  String? batch;
  @JsonKey(name: 'series')
  SeriesDto? series;
  @JsonKey(name: 'expiry_at')
  String? expiryAt;
  @JsonKey(name: 'condition')
  String? condition;
  @JsonKey(name: 'quantity')
  String? quantity;
  @JsonKey(name: 'entry_at')
  String? entryAt;
  @JsonKey(name: 'remarks')
  String? remarks;
  @JsonKey(name: 'dimensions')
  DimensionsDto? dimensions;
  @JsonKey(name: 'isseries')
  String? isseries;

  @JsonKey(name: 'container')
  String? container;
  @JsonKey(name: 'weight')
  String? weight;


  InboundDto(
      {this.docnum,
      this.device,
      this.branch,
      this.asset,
      this.user,
      this.cartonId,
      this.customer,
      this.warehouse,
      this.location,
      this.batch,
      this.series,
      this.expiryAt,
      this.condition,
      this.quantity,
      this.entryAt,
      this.remarks,
      this.dimensions,
      this.isseries,
      this.container,
      this.weight});

  factory InboundDto.fromJson(Map<String, dynamic> json)  => _$InboundDtoFromJson(json);

  Map<String, dynamic> toJson() => _$InboundDtoToJson(this);
}
