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
      branch: _$JsonConverterFromJson<Map<String, dynamic>, CommonType>(
          json['Branch'], const CommonTypeConverter().fromJson),
      container: _$JsonConverterFromJson<Map<String, dynamic>, CommonType>(
          json['Container'], const CommonTypeConverter().fromJson),
      asset: _$JsonConverterFromJson<Map<String, dynamic>, CommonType>(
          json['Asset'], const CommonTypeConverter().fromJson),
      customer: _$JsonConverterFromJson<Map<String, dynamic>, CommonType>(
          json['Customer'], const CommonTypeConverter().fromJson),
      warehouse: _$JsonConverterFromJson<Map<String, dynamic>, CommonType>(
          json['Warehouse'], const CommonTypeConverter().fromJson),
      location: _$JsonConverterFromJson<Map<String, dynamic>, CommonType>(
          json['Location'], const CommonTypeConverter().fromJson),
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
      'Branch': _$JsonConverterToJson<Map<String, dynamic>, CommonType>(
          instance.branch, const CommonTypeConverter().toJson),
      'Container': _$JsonConverterToJson<Map<String, dynamic>, CommonType>(
          instance.container, const CommonTypeConverter().toJson),
      'Asset': _$JsonConverterToJson<Map<String, dynamic>, CommonType>(
          instance.asset, const CommonTypeConverter().toJson),
      'Customer': _$JsonConverterToJson<Map<String, dynamic>, CommonType>(
          instance.customer, const CommonTypeConverter().toJson),
      'Warehouse': _$JsonConverterToJson<Map<String, dynamic>, CommonType>(
          instance.warehouse, const CommonTypeConverter().toJson),
      'Location': _$JsonConverterToJson<Map<String, dynamic>, CommonType>(
          instance.location, const CommonTypeConverter().toJson),
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
