

import 'package:cct_management/domain/dtos/series_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class OutgoingDto {
  String? docnum;
  String? device;
  String? asset;
  String? cartonId;
  String? warehouse;
  String? location;
  String? isSeries;
  SeriesDto? series;
  String? quantity;
  String? customer;
  String? batch;

  OutgoingDto(
      {this.docnum,
        this.device,
        this.asset,
        this.cartonId,
        this.warehouse,
        this.location,
        this.isSeries,
        this.series,
        this.quantity,
      this.customer,
      this.batch});

  OutgoingDto.fromJson(Map<String, dynamic> json) {
    docnum = json['docnum'];
    device = json['device'];
    asset = json['asset'];
    cartonId = json['cartonid'];
    warehouse = json['warehouse'];
    location = json['location'];
    isSeries = json['isseries'];
    series = json['series'];
    quantity = json['quantity'];
    customer = json['customer'];
    batch = json['batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['docnum'] = this.docnum;
    data['device'] = this.device;
    data['asset'] = this.asset;
    data['cartonid'] = this.cartonId;
    data['warehouse'] = this.warehouse;
    data['location'] = this.location;
    data['isseries'] = this.isSeries;
    data['series'] = this.series;
    data['quantity'] = this.quantity;
    data['customer'] = this.customer;
    data['batch'] = this.batch;
    return data;
  }
}