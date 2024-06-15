

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class InboundDto {
  String? _docnum;
  String? _lpn;
  String? _customer;
  String? _warehouse;
  String? _location;
  String? _batch;
  String? _serie;
  String? _expiryAt;
  String? _condition;
  String? _quantity;
  String? _entryAt;
  String? _remarks;

  InboundDto(
      {String? docnum,
        String? lpn,
        String? customer,
        String? warehouse,
        String? location,
        String? batch,
        String? serie,
        String? expiryAt,
        String? condition,
        String? quantity,
        String? entryAt,
        String? remarks}) {
    if (docnum != null) {
      this._docnum = docnum;
    }
    if (lpn != null) {
      this._lpn = lpn;
    }
    if (customer != null) {
      this._customer = customer;
    }
    if (warehouse != null) {
      this._warehouse = warehouse;
    }
    if (location != null) {
      this._location = location;
    }
    if (batch != null) {
      this._batch = batch;
    }
    if (serie != null) {
      this._serie = serie;
    }
    if (expiryAt != null) {
      this._expiryAt = expiryAt;
    }
    if (condition != null) {
      this._condition = condition;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (entryAt != null) {
      this._entryAt = entryAt;
    }
    if (remarks != null) {
      this._remarks = remarks;
    }
  }

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
  String? get condition => _condition;
  set condition(String? condition) => _condition = condition;
  String? get quantity => _quantity;
  set quantity(String? quantity) => _quantity = quantity;
  String? get entryAt => _entryAt;
  set entryAt(String? entryAt) => _entryAt = entryAt;
  String? get remarks => _remarks;
  set remarks(String? remarks) => _remarks = remarks;

  InboundDto.fromJson(Map<String, dynamic> json) {
    _docnum = json['docnum'];
    _lpn = json['lpn'];
    _customer = json['customer'];
    _warehouse = json['warehouse'];
    _location = json['location'];
    _batch = json['batch'];
    _serie = json['serie'];
    _expiryAt = json['expiry_at'];
    _condition = json['condition'];
    _quantity = json['quantity'];
    _entryAt = json['entry_at'];
    _remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docnum'] = this._docnum;
    data['lpn'] = this._lpn;
    data['customer'] = this._customer;
    data['warehouse'] = this._warehouse;
    data['location'] = this._location;
    data['batch'] = this._batch;
    data['serie'] = this._serie;
    data['expiry_at'] = this._expiryAt;
    data['condition'] = this._condition;
    data['quantity'] = this._quantity;
    data['entry_at'] = this._entryAt;
    data['remarks'] = this._remarks;
    return data;
  }
}