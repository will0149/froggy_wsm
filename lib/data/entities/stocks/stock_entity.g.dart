// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockEntity _$StockEntityFromJson(Map<String, dynamic> json) => StockEntity(
      id: (json['id'] as num?)?.toInt(),
      dmc: json['dmc'] as String?,
      weight: json['weight'] as String?,
      dimensions: json['dimensions'] == null
          ? null
          : DimensionEntity.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      cartonid: json['cartonid'] as String?,
      batch: json['batch'] as String?,
      series: _$JsonConverterFromJson<Map<String, dynamic>, SeriesSeriesDto>(
          json['series'], const ListSeriesConverter().fromJson),
      expiryAt: json['expiry_at'] as String?,
      condition: json['condition'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      entryAt: json['entry_at'] as String?,
      exitAt: json['exit_at'] as String?,
      remarks: json['remarks'] as String?,
      deleted: json['deleted'] as bool?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      branch: json['branch'] as String?,
      container: json['container'] as String?,
      asset: json['asset'] as String?,
      customer: json['customer'] as String?,
      warehouse: json['warehouse'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$StockEntityToJson(StockEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'dmc': instance.dmc,
      'weight': instance.weight,
      'dimensions': instance.dimensions?.toJson(),
      'cartonid': instance.cartonid,
      'batch': instance.batch,
      'series': _$JsonConverterToJson<Map<String, dynamic>, SeriesSeriesDto>(
          instance.series, const ListSeriesConverter().toJson),
      'expiry_at': instance.expiryAt,
      'condition': instance.condition,
      'quantity': instance.quantity,
      'entry_at': instance.entryAt,
      'exit_at': instance.exitAt,
      'remarks': instance.remarks,
      'deleted': instance.deleted,
      'deleted_at': instance.deletedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'branch': instance.branch,
      'container': instance.container,
      'asset': instance.asset,
      'customer': instance.customer,
      'warehouse': instance.warehouse,
      'location': instance.location,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
