// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relocation_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RelocationDto _$RelocationDtoFromJson(Map<String, dynamic> json) =>
    RelocationDto(
      asset: json['asset'] as String?,
      series: json['series'] == null
          ? null
          : SeriesDto.fromJson(json['series'] as Map<String, dynamic>),
      branch: json['branch'] as String?,
      fromCartonId: json['fromcartonid'] as String?,
      fromwarehouse: json['fromwarehouse'] as String?,
      fromlocation: json['fromlocation'] as String?,
      towardsCartonId: json['towardscartonid'] as String?,
      towardswarehouse: json['towardswarehouse'] as String?,
      towardslocation: json['towardslocation'] as String?,
      quantity: json['quantity'] as String?,
      remarks: json['remarks'] as String?,
      isseries: json['isseries'] as String?,
    );

Map<String, dynamic> _$RelocationDtoToJson(RelocationDto instance) =>
    <String, dynamic>{
      'asset': instance.asset,
      'series': instance.series?.toJson(),
      'branch': instance.branch,
      'fromcartonid': instance.fromCartonId,
      'fromwarehouse': instance.fromwarehouse,
      'fromlocation': instance.fromlocation,
      'towardscartonid': instance.towardsCartonId,
      'towardswarehouse': instance.towardswarehouse,
      'towardslocation': instance.towardslocation,
      'quantity': instance.quantity,
      'remarks': instance.remarks,
      'isseries': instance.isseries,
    };
