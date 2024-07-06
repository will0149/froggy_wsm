import 'package:cct_management/domain/dtos/series_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/11/24
 */

class InboundDto {
  String? docnum;
  String? device;
  String? branch;
  String? asset;
  String? user;
  String? cartonId;
  String? customer;
  String? warehouse;
  String? location;
  String? batch;
  SeriesDto? series;
  String? expiryAt;
  String? condition;
  String? quantity;
  String? entryAt;
  String? remarks;
  String? dimensions;

  InboundDto(
      {this.docnum,
      this.device,
      this.branch,
      this.asset,
      this.user,
      this.cartonId,
      this.customer,
      this.warehouse,
      this.location,
      this.batch,
      this.series,
      this.expiryAt,
      this.condition,
      this.quantity,
      this.entryAt,
      this.remarks,
      this.dimensions});

  InboundDto.fromJson(Map<String, dynamic> json) {
    docnum = json['docnum'];
    device = json['device'];
    branch = json['branch'];
    asset = json['asset'];
    user = json['user'];
    cartonId = json['cartonId'];
    customer = json['customer'];
    warehouse = json['warehouse'];
    location = json['location'];
    batch = json['batch'];
    series =
        json['series'] != null ? SeriesDto.fromJson(json['series']) : null;
    expiryAt = json['expiry_at'];
    condition = json['condition'];
    quantity = json['quantity'];
    entryAt = json['entry_at'];
    remarks = json['remarks'];
    dimensions = json['dimensions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['docnum'] = this.docnum;
    data['device'] = this.device;
    data['branch'] = this.branch;
    data['asset'] = this.asset;
    data['user'] = this.user;
    data['cartonId'] = this.cartonId;
    data['customer'] = this.customer;
    data['warehouse'] = this.warehouse;
    data['location'] = this.location;
    data['batch'] = this.batch;
    if (this.series != null) {
      data['series'] = this.series!.toJson();
    }
    data['expiry_at'] = this.expiryAt;
    data['condition'] = this.condition;
    data['quantity'] = this.quantity;
    data['entry_at'] = this.entryAt;
    data['remarks'] = this.remarks;
    data['dimensions'] = this.dimensions;
    return data;
  }
}
