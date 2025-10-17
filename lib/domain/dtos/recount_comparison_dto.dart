import 'package:json_annotation/json_annotation.dart';

/**
 * Made for froggy_soft.
 * By User: josedominguez
 * Date: 10/15/25
 */

part 'recount_comparison_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RecountComparisonDto {
  @JsonKey(name: 'reference')
  String? reference;

  @JsonKey(name: 'countQty')
  int? countQty;

  @JsonKey(name: 'serviceQty')
  int? serviceQty;

  int? get difference => (serviceQty ?? 0) - (countQty ?? 0);

  RecountComparisonDto({
    this.reference,
    this.countQty,
    this.serviceQty,
  });

  factory RecountComparisonDto.fromJson(Map<String, dynamic> json) =>
      _$RecountComparisonDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RecountComparisonDtoToJson(this);
}
