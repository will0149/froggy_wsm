

import 'package:json_annotation/json_annotation.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

@JsonSerializable(
  genericArgumentFactories: true,
)
class StatusEntity {
  @JsonKey(name: 'code')
  String? _code;
  @JsonKey(name: 'msg')
  String? _msg;

  StatusEntity({String? code, String? msg}) {
    if (code != null) {
      this._code = code;
    }
    if (msg != null) {
      this._msg = msg;
    }
  }

  String? get code => _code;
  set code(String? code) => _code = code;
  String? get msg => _msg;
  set msg(String? msg) => _msg = msg;

  StatusEntity.fromJson(Map<String, dynamic> json) {
    _code = json['code'].toString();
    _msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['msg'] = this._msg;
    return data;
  }
}
