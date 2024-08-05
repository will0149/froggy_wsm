

import 'package:json_annotation/json_annotation.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/12/24

@JsonSerializable(
  genericArgumentFactories: true,
)
class RelocationDataEntity {
  bool? _deleted;
  String? _deletedAt;
  int? _id;
  String? _lpn;
  String? _serie;
  String? _quantity;
  String? _updatedAt;
  String? _createdAt;

  RelocationDataEntity(
      {bool? deleted,
      String? deletedAt,
      int? id,
      String? lpn,
      String? serie,
      String? quantity,
      String? updatedAt,
      String? createdAt}) {
    if (deleted != null) {
      _deleted = deleted;
    }
    if (deletedAt != null) {
      _deletedAt = deletedAt;
    }
    if (id != null) {
      _id = id;
    }
    if (lpn != null) {
      _lpn = lpn;
    }
    if (serie != null) {
      _serie = serie;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
  }

  bool? get deleted => _deleted;
  set deleted(bool? deleted) => _deleted = deleted;
  String? get deletedAt => _deletedAt;
  set deletedAt(String? deletedAt) => _deletedAt = deletedAt;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get lpn => _lpn;
  set lpn(String? lpn) => _lpn = lpn;
  String? get serie => _serie;
  set serie(String? serie) => _serie = serie;
  String? get quantity => _quantity;
  set quantity(String? quantity) => _quantity = quantity;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  RelocationDataEntity.fromJson(Map<String, dynamic> json) {
    _deleted = json['deleted'];
    _deletedAt = json['deleted_at'];
    _id = json['id'];
    _lpn = json['lpn'];
    _serie = json['serie'];
    _quantity = json['quantity'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deleted'] = _deleted;
    data['deleted_at'] = _deletedAt;
    data['id'] = _id;
    data['lpn'] = _lpn;
    data['serie'] = _serie;
    data['quantity'] = _quantity;
    data['updated_at'] = _updatedAt;
    data['created_at'] = _createdAt;
    return data;
  }
}
