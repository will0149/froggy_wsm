

import 'package:froggy_soft/domain/dtos/series_dto.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 06/12/24
 */
part 'outgoing_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class OutgoingDto {
  @JsonKey(name: 'docnum')
  String? docnum;
  @JsonKey(name: 'device')
  String? device = 'device';
  @JsonKey(name: 'asset')
  String? asset;
  @JsonKey(name: 'cartonid')
  String? cartonId;
  @JsonKey(name: 'warehouse')
  String? warehouse;
  @JsonKey(name: 'location')
  String? location;
  @JsonKey(name: 'isseries')
  String? isSeries;
  @JsonKey(name: 'series')
  SeriesDto? series;
  @JsonKey(name: 'quantity')
  String? quantity;

  OutgoingDto(
      {this.docnum,
        this.device,
        this.asset,
        this.cartonId,
        this.warehouse,
        this.location,
        this.isSeries,
        this.series,
        this.quantity});

  factory OutgoingDto.fromJson(Map<String, dynamic> json)  => _$OutgoingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OutgoingDtoToJson(this);
}