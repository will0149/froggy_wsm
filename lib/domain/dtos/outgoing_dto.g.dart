// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outgoing_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutgoingDto _$OutgoingDtoFromJson(Map<String, dynamic> json) => OutgoingDto(
      docnum: json['docnum'] as String?,
      device: json['device'] as String?,
      asset: json['asset'] as String?,
      cartonId: json['cartonid'] as String?,
      warehouse: json['warehouse'] as String?,
      location: json['location'] as String?,
      isSeries: json['isseries'] as String?,
      series: json['series'] == null
          ? null
          : SeriesDto.fromJson(json['series'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
    );

Map<String, dynamic> _$OutgoingDtoToJson(OutgoingDto instance) =>
    <String, dynamic>{
      'docnum': instance.docnum,
      'device': instance.device,
      'asset': instance.asset,
      'cartonid': instance.cartonId,
      'warehouse': instance.warehouse,
      'location': instance.location,
      'isseries': instance.isSeries,
      'series': instance.series?.toJson(),
      'quantity': instance.quantity,
    };
