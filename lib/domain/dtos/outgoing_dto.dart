

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class OutgoingDto {
  String? _docnum;
  String? _lpn;
  String? _customer;
  String? _warehouse;
  String? _location;
  String? _batch;
  String? _serie;
  String? _quantity;
  String? _exitAt;
  String? _remarks;

  OutgoingDto(
      {String? docnum,
        String? lpn,
        String? customer,
        String? warehouse,
        String? location,
        String? batch,
        String? serie,
        String? quantity,
        String? exitAt,
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
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (exitAt != null) {
      this._exitAt = exitAt;
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
  String? get quantity => _quantity;
  set quantity(String? quantity) => _quantity = quantity;
  String? get exitAt => _exitAt;
  set exitAt(String? exitAt) => _exitAt = exitAt;
  String? get remarks => _remarks;
  set remarks(String? remarks) => _remarks = remarks;

  OutgoingDto.fromJson(Map<String, dynamic> json) {
    _docnum = json['docnum'];
    _lpn = json['lpn'];
    _customer = json['customer'];
    _warehouse = json['warehouse'];
    _location = json['location'];
    _batch = json['batch'];
    _serie = json['serie'];
    _quantity = json['quantity'];
    _exitAt = json['exit_at'];
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
    data['quantity'] = this._quantity;
    data['exit_at'] = this._exitAt;
    data['remarks'] = this._remarks;
    return data;
  }
}