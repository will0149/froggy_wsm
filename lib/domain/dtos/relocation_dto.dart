

import 'package:froggy_soft/domain/dtos/series_dto.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 06/12/24
 */

part 'relocation_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RelocationDto {
  @JsonKey(name: 'device')
  String? device = 'device';
  @JsonKey(name: 'asset')
  String? asset;
  @JsonKey(name: 'series')
  SeriesDto? series;
  @JsonKey(name: 'branch')
  String? branch;
  @JsonKey(name: 'fromcartonid')
  String? fromCartonId;
  @JsonKey(name: 'fromwarehouse')
  String? fromwarehouse;
  @JsonKey(name: 'fromlocation')
  String? fromlocation;
  @JsonKey(name: 'towardscartonid')
  String? towardsCartonId;
  @JsonKey(name: 'towardswarehouse')
  String? towardswarehouse;
  @JsonKey(name: 'towardslocation')
  String? towardslocation;
  @JsonKey(name: 'quantity')
  String? quantity;
  @JsonKey(name: 'remarks')
  String? remarks;
  @JsonKey(name: 'isseries')
  String? isseries;

  RelocationDto(
      {this.asset,
        this.series,
        this.branch,
        this.fromCartonId,
        this.fromwarehouse,
        this.fromlocation,
        this.towardsCartonId,
        this.towardswarehouse,
        this.towardslocation,
        this.quantity,
        this.remarks,
      this.isseries});

  factory RelocationDto.fromJson(Map<String, dynamic> json) => _$RelocationDtoFromJson(json);

  Map<String, dynamic> toJson()  => _$RelocationDtoToJson(this);
}
