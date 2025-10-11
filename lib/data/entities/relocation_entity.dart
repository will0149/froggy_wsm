import 'package:froggy_soft/data/entities/relocation_data_entity.dart';
import 'package:json_annotation/json_annotation.dart';

/// Made for froggysoft.
/// By User: josedominguez
/// Date: 06/12/24

@JsonSerializable(
  genericArgumentFactories: true,
)
class RelocationEntity {
  RelocationDataEntity? _data;

  RelocationEntity({RelocationDataEntity? data}) {
    if (data != null) {
      _data = data;
    }
  }

  RelocationDataEntity? get data => _data;
  set data(RelocationDataEntity? data) => _data = data;

  RelocationEntity.fromJson(Map<String, dynamic> json) {
    _data = json['data'] != null ? RelocationDataEntity.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_data != null) {
      data['data'] = _data!.toJson();
    }
    return data;
  }
}
