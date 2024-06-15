

import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

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
      this._deleted = deleted;
    }
    if (deletedAt != null) {
      this._deletedAt = deletedAt;
    }
    if (id != null) {
      this._id = id;
    }
    if (lpn != null) {
      this._lpn = lpn;
    }
    if (serie != null) {
      this._serie = serie;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deleted'] = this._deleted;
    data['deleted_at'] = this._deletedAt;
    data['id'] = this._id;
    data['lpn'] = this._lpn;
    data['serie'] = this._serie;
    data['quantity'] = this._quantity;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    return data;
  }
}
