

import 'package:cct_management/domain/dtos/series_dto.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

part 'tally_count_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class TallyCountDto {
  @JsonKey(name: 'device')
  String? device;
  @JsonKey(name: 'branch')
  String? branch;
  @JsonKey(name: 'asset')
  String? asset;
  @JsonKey(name: 'warehouse')
  String? warehouse;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'cartonid')
  String? cartonid;
  @JsonKey(name: 'isseries')
  String? isSeries;
  @JsonKey(name: 'series')
  SeriesDto? series;
  @JsonKey(name: 'quantity')
  String? quantity;
  @JsonKey(name: 'remark')
  String? remark;

  TallyCountDto(
      {this.device,
        this.branch,
        this.asset,
        this.warehouse,
        this.location,
        this.cartonid,
        this.isSeries,
        this.series,
        this.quantity,
        this.remark});

  factory TallyCountDto.fromJson(Map<String, dynamic> json) => _$TallyCountDtoFromJson(json);

  Map<String, dynamic> toJson() => _$TallyCountDtoToJson(this);

}