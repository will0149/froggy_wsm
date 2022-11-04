import 'package:flutter/material.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */

class UserDTO {
  final int id;
  final String firstName;
  final String? lastName;
  final String phoneNumber;
  final String emailAddress;
  final String? profileImage;

  UserDTO(
      {required this.id,
      required this.firstName,
      this.lastName,
      required this.phoneNumber,
      required this.emailAddress,
      this.profileImage});

  factory UserDTO.fromJson(Map<String, dynamic> json) => UserDTO(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        emailAddress: json["emailAddress"],
        profileImage: json["profileImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "emailAddress": emailAddress,
        "profileImage": profileImage
      };
}
