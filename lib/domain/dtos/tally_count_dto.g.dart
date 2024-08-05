// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tally_count_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TallyCountDto _$TallyCountDtoFromJson(Map<String, dynamic> json) =>
    TallyCountDto(
      device: json['device'] as String?,
      branch: json['branch'] as String?,
      asset: json['asset'] as String?,
      warehouse: json['warehouse'] as String?,
      location: json['location'] as String?,
      cartonid: json['cartonid'] as String?,
      isSeries: json['isseries'] as String?,
      series: json['series'] == null
          ? null
          : SeriesDto.fromJson(json['series'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
      remark: json['remark'] as String?,
    );

Map<String, dynamic> _$TallyCountDtoToJson(TallyCountDto instance) =>
    <String, dynamic>{
      'device': instance.device,
      'branch': instance.branch,
      'asset': instance.asset,
      'warehouse': instance.warehouse,
      'location': instance.location,
      'cartonid': instance.cartonid,
      'isseries': instance.isSeries,
      'series': instance.series?.toJson(),
      'quantity': instance.quantity,
      'remark': instance.remark,
    };
