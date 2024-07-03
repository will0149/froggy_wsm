

import 'package:cct_management/domain/dtos/series_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class RelocationDto {
  String? user;
  String? asset;
  SeriesDto? series;
  String? branch;
  String? fromlpn;
  String? fromwarehouse;
  String? fromlocation;
  String? towardslpn;
  String? towardswarehouse;
  String? towardslocation;
  String? quantity;
  String? remarks;
  String? isseries;

  RelocationDto(
      {this.user,
        this.asset,
        this.series,
        this.branch,
        this.fromlpn,
        this.fromwarehouse,
        this.fromlocation,
        this.towardslpn,
        this.towardswarehouse,
        this.towardslocation,
        this.quantity,
        this.remarks,
      this.isseries});

  RelocationDto.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    asset = json['asset'];
    series =
    json['series'] != null ? new SeriesDto.fromJson(json['series']) : null;
    branch = json['branch'];
    fromlpn = json['fromlpn'];
    fromwarehouse = json['fromwarehouse'];
    fromlocation = json['fromlocation'];
    towardslpn = json['towardslpn'];
    towardswarehouse = json['towardswarehouse'];
    towardslocation = json['towardslocation'];
    quantity = json['quantity'];
    remarks = json['remarks'];
    isseries = json['isseries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['asset'] = this.asset;
    if (this.series != null) {
      data['series'] = this.series!.toJson();
    }
    data['branch'] = this.branch;
    data['fromlpn'] = this.fromlpn;
    data['fromwarehouse'] = this.fromwarehouse;
    data['fromlocation'] = this.fromlocation;
    data['towardslpn'] = this.towardslpn;
    data['towardswarehouse'] = this.towardswarehouse;
    data['towardslocation'] = this.towardslocation;
    data['quantity'] = this.quantity;
    data['remarks'] = this.remarks;
    data['isseries'] = this.isseries;
    return data;
  }
}
