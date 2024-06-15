import 'package:cct_management/data/entities/status_entity.dart';
import 'package:json_annotation/json_annotation.dart';
/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/13/24
 */
// @JsonSerializable(
//   genericArgumentFactories: true,
// )
// class BaseEntityFunc<T> {
//   @JsonKey(name: 'body')
//   T Function(Map<String, dynamic>? json)? body;
//
//   @JsonKey(name: 'status')
//   StatusEntity? _status;
//
//   BaseEntityFunc({this.body, StatusEntity? status}) {
//     if (status != null) {
//       this._status = status;
//     }
//   }
//
//   StatusEntity? get status => _status;
//   set status(StatusEntity? status) => _status = status;
//
//   factory BaseEntityFunc.fromJson(
//       Map<String, dynamic> json, T Function(Map<String, dynamic>? json) fromJsonT) =>
//       BaseEntityFunc(
//           body: fromJsonT,
//           status: json['status'] != null
//               ? StatusEntity.fromJson(json['status'])
//               : null);
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (this.body != null) {
//       data['body'] = this.body;
//     }
//     if (this._status != null) {
//       data['status'] = this._status!.toJson();
//     }
//     return data;
//   }
// }
