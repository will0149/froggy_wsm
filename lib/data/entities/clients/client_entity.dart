import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/16/24
 */

part 'client_entity.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class ClientEntity {
  @JsonKey(name: 'id')
  int? _id;
  @JsonKey(name: 'name')
  String? _name;
  @JsonKey(name: 'description')
  String? _description;
  @JsonKey(name: 'barcode')
  String? _barcode;
  @JsonKey(name: 'deleted')
  bool? _deleted;
  @JsonKey(name: 'deletedAt')
  String? _deletedAt;
  @JsonKey(name: 'createdAt')
  String? _createdAt;
  @JsonKey(name: 'updatedAt')
  String? _updatedAt;

  ClientEntity(
      {int? id,
        String? name,
        String? description,
        String? barcode,
        bool? deleted,
        String? deletedAt,
        String? createdAt,
        String? updatedAt}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (barcode != null) {
      this._barcode = barcode;
    }
    if (deleted != null) {
      this._deleted = deleted;
    }
    if (deletedAt != null) {
      this._deletedAt = deletedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get barcode => _barcode;
  set barcode(String? barcode) => _barcode = barcode;
  bool? get deleted => _deleted;
  set deleted(bool? deleted) => _deleted = deleted;
  String? get deletedAt => _deletedAt;
  set deletedAt(String? deletedAt) => _deletedAt = deletedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;

  ClientEntity.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _barcode = json['barcode'];
    _deleted = json['deleted'];
    _deletedAt = json['deleted_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    data['description'] = this._description;
    data['barcode'] = this._barcode;
    data['deleted'] = this._deleted;
    data['deleted_at'] = this._deletedAt;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}