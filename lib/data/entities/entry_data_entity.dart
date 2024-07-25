

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

/// Made for cct_management.
/// By User: josedominguez
/// Date: 06/12/24

@JsonSerializable(
  genericArgumentFactories: true,
)
class EntryDataEntity {
  @JsonKey(name: 'deleted')
  bool? _deleted;
  @JsonKey(name: 'deletedAt')
  String? _deletedAt;
  @JsonKey(name: 'id')
  int? _id;
  @JsonKey(name: 'docnum')
  String? _docnum;
  @JsonKey(name: 'lpn')
  String? _lpn;
  @JsonKey(name: 'customer')
  String? _customer;
  @JsonKey(name: 'warehouse')
  String? _warehouse;
  @JsonKey(name: 'location')
  String? _location;
  @JsonKey(name: 'batch')
  String? _batch;
  @JsonKey(name: 'series')
  String? _serie;
  @JsonKey(name: 'expiryAt')
  String? _expiryAt;
  @JsonKey(name: 'condition')
  bool? _condition;
  @JsonKey(name: 'quantity')
  int? _quantity;
  @JsonKey(name: 'entryAt')
  String? _entryAt;
  @JsonKey(name: 'remarks')
  String? _remarks;
  @JsonKey(name: 'updatedAt')
  String? _updatedAt;
  @JsonKey(name: 'createdAt')
  String? _createdAt;

  EntryDataEntity(
      {bool? deleted,
        String? deletedAt,
        int? id,
        String? docnum,
        String? lpn,
        String? customer,
        String? warehouse,
        String? location,
        String? batch,
        String? serie,
        String? expiryAt,
        bool? condition,
        int? quantity,
        String? entryAt,
        String? remarks,
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
    if (docnum != null) {
      _docnum = docnum;
    }
    if (lpn != null) {
      _lpn = lpn;
    }
    if (customer != null) {
      _customer = customer;
    }
    if (warehouse != null) {
      _warehouse = warehouse;
    }
    if (location != null) {
      _location = location;
    }
    if (batch != null) {
      _batch = batch;
    }
    if (serie != null) {
      _serie = serie;
    }
    if (expiryAt != null) {
      _expiryAt = expiryAt;
    }
    if (condition != null) {
      _condition = condition;
    }
    if (quantity != null) {
      _quantity = quantity;
    }
    if (entryAt != null) {
      _entryAt = entryAt;
    }
    if (remarks != null) {
      _remarks = remarks;
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
  String? get docnum => _docnum;
  set docnum(String? docnum) => _docnum = docnum;
  String? get lpn => _lpn;
  set lpn(String? lpn) => _lpn = lpn;
  String? get customer => _customer;
  set customer(String? customer) => _customer = customer;
  String? get warehouse => _warehouse;
  set warehouse(String? warehouse) => _warehouse = warehouse;
  String? get location => _location;
  set location(String? location) => _location = location;
  String? get batch => _batch;
  set batch(String? batch) => _batch = batch;
  String? get serie => _serie;
  set serie(String? serie) => _serie = serie;
  String? get expiryAt => _expiryAt;
  set expiryAt(String? expiryAt) => _expiryAt = expiryAt;
  bool? get condition => _condition;
  set condition(bool? condition) => _condition = condition;
  int? get quantity => _quantity;
  set quantity(int? quantity) => _quantity = quantity;
  String? get entryAt => _entryAt;
  set entryAt(String? entryAt) => _entryAt = entryAt;
  String? get remarks => _remarks;
  set remarks(String? remarks) => _remarks = remarks;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  EntryDataEntity.fromJson(Map<String, dynamic> json) {
    _deleted = json['deleted'];
    _deletedAt = json['deleted_at'];
    _id = json['id'];
    _docnum = json['docnum'];
    _lpn = json['lpn'];
    _customer = json['customer'];
    _warehouse = json['warehouse'];
    _location = json['location'];
    _batch = json['batch'];
    _serie = json['serie'];
    _expiryAt = json['expiry_at'];
    _condition = jsonDecode(json['condition'].toString()) as bool;
    _quantity = jsonDecode(json['quantity'].toString()) as int;
    _entryAt = json['entry_at'];
    _remarks = json['remarks'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['deleted'] = _deleted;
    data['deleted_at'] = _deletedAt;
    data['id'] = _id;
    data['docnum'] = _docnum;
    data['lpn'] = _lpn;
    data['customer'] = _customer;
    data['warehouse'] = _warehouse;
    data['location'] = _location;
    data['batch'] = _batch;
    data['serie'] = _serie;
    data['expiry_at'] = _expiryAt;
    data['condition'] = _condition;
    data['quantity'] = _quantity;
    data['entry_at'] = _entryAt;
    data['remarks'] = _remarks;
    data['updated_at'] = _updatedAt;
    data['created_at'] = _createdAt;
    return data;
  }
}