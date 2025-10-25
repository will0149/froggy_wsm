import 'package:json_annotation/json_annotation.dart';

import 'body_stocks_entity.dart';

/**
 * Made for froggysoft.
 * By User: josedominguez
 * Date: 08/13/24
 */
part 'stock_list_entity.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class StockListEntity{
  @JsonKey(name: 'series')
  List<BodyStocksEntity>? series = [];

  StockListEntity({this.series});

  factory StockListEntity.fromJson(Map<String, dynamic> json)  => _$StockListEntityFromJson(json);

  Map<String, dynamic> toJson() => _$StockListEntityToJson(this);
}