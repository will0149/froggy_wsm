

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class TallyCountDto {
  String? _warehouse;
  String? _location;
  String? _lpn;
  String? _serie;
  String? _quantity;
  String? _remark;

  TallyCountDto(
      {String? warehouse,
        String? location,
        String? lpn,
        String? serie,
        String? quantity,
        String? remark}) {
    if (warehouse != null) {
      this._warehouse = warehouse;
    }
    if (location != null) {
      this._location = location;
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
    if (remark != null) {
      this._remark = remark;
    }
  }

  String? get warehouse => _warehouse;
  set warehouse(String? warehouse) => _warehouse = warehouse;
  String? get location => _location;
  set location(String? location) => _location = location;
  String? get lpn => _lpn;
  set lpn(String? lpn) => _lpn = lpn;
  String? get serie => _serie;
  set serie(String? serie) => _serie = serie;
  String? get quantity => _quantity;
  set quantity(String? quantity) => _quantity = quantity;
  String? get remark => _remark;
  set remark(String? remark) => _remark = remark;

  TallyCountDto.fromJson(Map<String, dynamic> json) {
    _warehouse = json['warehouse'];
    _location = json['location'];
    _lpn = json['lpn'];
    _serie = json['serie'];
    _quantity = json['quantity'];
    _remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouse'] = this._warehouse;
    data['location'] = this._location;
    data['lpn'] = this._lpn;
    data['serie'] = this._serie;
    data['quantity'] = this._quantity;
    data['remark'] = this._remark;
    return data;
  }
}