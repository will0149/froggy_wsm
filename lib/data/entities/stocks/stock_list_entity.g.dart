// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_list_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockListEntity _$StockListEntityFromJson(Map<String, dynamic> json) =>
    StockListEntity(
      series: (json['series'] as List<dynamic>?)
          ?.map((e) => BodyStocksEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StockListEntityToJson(StockListEntity instance) =>
    <String, dynamic>{
      'series': instance.series,
    };
