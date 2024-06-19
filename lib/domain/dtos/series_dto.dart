import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/18/24
 */

class SeriesDto {
  List<String>? series;

  SeriesDto({this.series});

  SeriesDto.fromJson(Map<String, dynamic> json) {
    series = json['series'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['series'] = this.series;
    return data;
  }
}