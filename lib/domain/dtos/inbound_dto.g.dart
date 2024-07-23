// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbound_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InboundDto _$InboundDtoFromJson(Map<String, dynamic> json) => InboundDto(
      docnum: json['docnum'] as String?,
      device: json['device'] as String?,
      branch: json['branch'] as String?,
      asset: json['asset'] as String?,
      user: json['user'] as String?,
      cartonId: json['cartonid'] as String?,
      customer: json['customer'] as String?,
      warehouse: json['warehouse'] as String?,
      location: json['location'] as String?,
      batch: json['batch'] as String?,
      series: json['series'] == null
          ? null
          : SeriesDto.fromJson(json['series'] as Map<String, dynamic>),
      expiryAt: json['expiry_at'] as String?,
      condition: json['condition'] as String?,
      quantity: json['quantity'] as String?,
      entryAt: json['entry_at'] as String?,
      remarks: json['remarks'] as String?,
      dimensions: json['dimensions'] == null
          ? null
          : DimensionsDto.fromJson(json['dimensions'] as Map<String, dynamic>),
      isseries: json['isseries'] as String?,
      container: json['container'] as String?,
    );

Map<String, dynamic> _$InboundDtoToJson(InboundDto instance) =>
    <String, dynamic>{
      'docnum': instance.docnum,
      'device': instance.device,
      'branch': instance.branch,
      'asset': instance.asset,
      'user': instance.user,
      'cartonid': instance.cartonId,
      'customer': instance.customer,
      'warehouse': instance.warehouse,
      'location': instance.location,
      'batch': instance.batch,
      'series': instance.series?.toJson(),
      'expiry_at': instance.expiryAt,
      'condition': instance.condition,
      'quantity': instance.quantity,
      'entry_at': instance.entryAt,
      'remarks': instance.remarks,
      'dimensions': instance.dimensions?.toJson(),
      'isseries': instance.isseries,
      'container': instance.container,
    };
