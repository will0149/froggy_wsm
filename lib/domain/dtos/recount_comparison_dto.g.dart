// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recount_comparison_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecountComparisonDto _$RecountComparisonDtoFromJson(
        Map<String, dynamic> json) =>
    RecountComparisonDto(
      reference: json['reference'] as String?,
      countQty: (json['countQty'] as num?)?.toInt(),
      serviceQty: (json['serviceQty'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$RecountComparisonDtoToJson(
        RecountComparisonDto instance) =>
    <String, dynamic>{
      'reference': instance.reference,
      'countQty': instance.countQty,
      'serviceQty': instance.serviceQty,
      'name': instance.name,
    };
