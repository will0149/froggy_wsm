

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/19/24
 */

class DimensionsDto {
  String? height;
  String? width;
  String? long;

  DimensionsDto({this.height, this.width, this.long});

  DimensionsDto.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    width = json['width'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['width'] = this.width;
    data['long'] = this.long;
    return data;
  }
}