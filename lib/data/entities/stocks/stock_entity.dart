
import 'package:cct_management/data/entities/commons/common_type.dart';
import 'package:cct_management/data/entities/stocks/dimension_entity.dart';
import 'package:cct_management/domain/convertes/common_type_converter.dart';
import 'package:cct_management/domain/convertes/list_series_converter.dart';
import 'package:cct_management/domain/dtos/series_series_dto.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 05/18/25
 */

part 'stock_entity.g.dart';

@JsonSerializable(explicitToJson: true)
class StockEntity {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'dmc')
  String? dmc;
  @JsonKey(name: 'weight')
  String? weight;
  @JsonKey(name: 'dimensions')
  DimensionEntity? dimensions;
  @JsonKey(name: 'cartonid')
  String? cartonid;
  @JsonKey(name: 'batch')
  String? batch;
  @ListSeriesConverter()
  @JsonKey(name: 'series')
  SeriesSeriesDto? series;
  @JsonKey(name: 'expiry_at')
  String? expiryAt;
  @JsonKey(name: 'condition')
  String? condition;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'entry_at')
  String? entryAt;
  @JsonKey(name: 'exit_at')
  String? exitAt;
  @JsonKey(name: 'remarks')
  String? remarks;
  @JsonKey(name: 'deleted')
  bool? deleted;
  @JsonKey(name: 'deleted_at')
  String? deletedAt;
  @JsonKey(name: 'created_at')
  String? createdAt;
  @JsonKey(name: 'updated_at')
  String? updatedAt;
  // @CommonTypeConverter()
  // @JsonKey(name: 'Branch')
  // CommonType? branch;
  String? branch;
  // @CommonTypeConverter()
  // @JsonKey(name: 'Container')
  // CommonType? container;
  String? container;
  // @CommonTypeConverter()
  // @JsonKey(name: 'Asset')
  // CommonType? asset;
  String? asset;
  // Object? user;
  // @CommonTypeConverter()
  // @JsonKey(name: 'Customer')
  // CommonType? customer;
  String? customer;
  // @CommonTypeConverter()
  // @JsonKey(name: 'Warehouse')
  // CommonType? warehouse;
  String? warehouse;
  // @CommonTypeConverter()
  // @JsonKey(name: 'Location')
  // CommonType? location;
  String? location;


  StockEntity(
      {this.id,
        this.dmc,
        this.weight,
        this.dimensions,
        this.cartonid,
        this.batch,
        this.series,
        this.expiryAt,
        this.condition,
        this.quantity,
        this.entryAt,
        this.exitAt,
        this.remarks,
        this.deleted,
        this.deletedAt,
        this.createdAt,
        this.updatedAt,
        this.branch,
        this.container,
        this.asset,
        // this.user,
        this.customer,
        this.warehouse,
        this.location});

  factory StockEntity.fromJson(Map<String, dynamic> json)  => _$StockEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StockEntityToJson(this);

}