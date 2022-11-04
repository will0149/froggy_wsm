import 'package:flutter/material.dart';
import 'package:parkea/data/repositories/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dtos/user_dto.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 11/03/22
 */

class UsersUC {
  late final UserRepository repository = UserRepository();

  Future<UserDTO> getUserDataByEmail(String email) async {
    Map<String, dynamic> result = await repository.fetchUsersList();

    List<dynamic> jsonResponse = result["body"]["users"];
    List<UserDTO> bodyResponse = [];
    jsonResponse.map((element) {
      bodyResponse.add(UserDTO.fromJson(element));
    }).toList();

    return bodyResponse.firstWhere((element) => element.emailAddress == email);
  }
}

final userApiProvider = Provider<UsersUC>((ref) => UsersUC());