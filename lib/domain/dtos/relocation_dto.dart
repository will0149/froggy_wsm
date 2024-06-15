

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class RelocationDto {
  String? _serie;
  String? _lpn;
  String? _towardswarehouse;
  String? _towardslocation;
  String? _fromwarehouse;
  String? _fromlocation;
  String? _quantity;
  String? _remarks;

  RelocationDto(
      {String? serie,
        String? lpn,
        String? towardswarehouse,
        String? towardslocation,
        String? fromwarehouse,
        String? fromlocation,
        String? quantity,
        String? remarks}) {
    if (serie != null) {
      this._serie = serie;
    }
    if (lpn != null) {
      this._lpn = lpn;
    }
    if (towardswarehouse != null) {
      this._towardswarehouse = towardswarehouse;
    }
    if (towardslocation != null) {
      this._towardslocation = towardslocation;
    }
    if (fromwarehouse != null) {
      this._fromwarehouse = fromwarehouse;
    }
    if (fromlocation != null) {
      this._fromlocation = fromlocation;
    }
    if (quantity != null) {
      this._quantity = quantity;
    }
    if (remarks != null) {
      this._remarks = remarks;
    }
  }

  String? get serie => _serie;
  set serie(String? serie) => _serie = serie;
  String? get lpn => _lpn;
  set lpn(String? lpn) => _lpn = lpn;
  String? get towardswarehouse => _towardswarehouse;
  set towardswarehouse(String? towardswarehouse) =>
      _towardswarehouse = towardswarehouse;
  String? get towardslocation => _towardslocation;
  set towardslocation(String? towardslocation) =>
      _towardslocation = towardslocation;
  String? get fromwarehouse => _fromwarehouse;
  set fromwarehouse(String? fromwarehouse) => _fromwarehouse = fromwarehouse;
  String? get fromlocation => _fromlocation;
  set fromlocation(String? fromlocation) => _fromlocation = fromlocation;
  String? get quantity => _quantity;
  set quantity(String? quantity) => _quantity = quantity;
  String? get remarks => _remarks;
  set remarks(String? remarks) => _remarks = remarks;

  RelocationDto.fromJson(Map<String, dynamic> json) {
    _serie = json['serie'];
    _lpn = json['lpn'];
    _towardswarehouse = json['towardswarehouse'];
    _towardslocation = json['towardslocation'];
    _fromwarehouse = json['fromwarehouse'];
    _fromlocation = json['fromlocation'];
    _quantity = json['quantity'];
    _remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['serie'] = this._serie;
    data['lpn'] = this._lpn;
    data['towardswarehouse'] = this._towardswarehouse;
    data['towardslocation'] = this._towardslocation;
    data['fromwarehouse'] = this._fromwarehouse;
    data['fromlocation'] = this._fromlocation;
    data['quantity'] = this._quantity;
    data['remarks'] = this._remarks;
    return data;
  }
}
