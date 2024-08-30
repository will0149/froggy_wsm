// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_stocks_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BodyStocksEntity _$BodyStocksEntityFromJson(Map<String, dynamic> json) =>
    BodyStocksEntity(
      cartonid: json['cartonid'] as String?,
      location: json['location'] as String?,
      warehouse: json['warehouse'] as String?,
      serie: json['serie'] as String?,
    );

Map<String, dynamic> _$BodyStocksEntityToJson(BodyStocksEntity instance) =>
    <String, dynamic>{
      'cartonid': instance.cartonid,
      'location': instance.location,
      'warehouse': instance.warehouse,
      'serie': instance.serie,
    };
