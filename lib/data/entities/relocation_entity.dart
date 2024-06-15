import 'package:cct_management/data/entities/relocation_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

@JsonSerializable(
  genericArgumentFactories: true,
)
class RelocationEntity {
  RelocationDataEntity? _data;

  RelocationEntity({RelocationDataEntity? data}) {
    if (data != null) {
      this._data = data;
    }
  }

  RelocationDataEntity? get data => _data;
  set data(RelocationDataEntity? data) => _data = data;

  RelocationEntity.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? new RelocationDataEntity.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.toJson();
    }
    return data;
  }
}
