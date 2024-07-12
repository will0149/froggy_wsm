

import 'package:cct_management/domain/dtos/series_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class TallyCountDto {
  String? device;
  String? branch;
  String? asset;
  String? warehouse;
  String? location;
  String? cartonid;
  String? isSeries;
  SeriesDto? series;
  String? quantity;
  String? remark;

  TallyCountDto(
      {this.device,
        this.branch,
        this.asset,
        this.warehouse,
        this.location,
        this.cartonid,
        this.isSeries,
        this.series,
        this.quantity,
        this.remark});

  TallyCountDto.fromJson(Map<String, dynamic> json) {
    device = json['device'];
    branch = json['branch'];
    asset = json['asset'];
    warehouse = json['warehouse'];
    location = json['location'];
    cartonid = json['cartonid'];
    isSeries = json['isseries'];
    series = json['series'];
    quantity = json['quantity'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device'] = this.device;
    data['branch'] = this.branch;
    data['asset'] = this.asset;
    data['warehouse'] = this.warehouse;
    data['location'] = this.location;
    data['cartonid'] = this.cartonid;
    data['isseries'] = this.isSeries;
    data['series'] = this.series;
    data['quantity'] = this.quantity;
    data['remark'] = this.remark;
    return data;
  }

}