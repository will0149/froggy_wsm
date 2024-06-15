import 'package:flutter/material.dart';

import '../../data/repositories/entry/operation_repository.dart';
import '../../device/utils/logger_config.dart';
import '../dtos/relocation_dto.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/12/24
 */

class RelocationLogic extends ChangeNotifier {
  late final OperationRepository repository;
  bool isLoading = false;

  RelocationLogic() {
    repository = OperationRepository();
  }
  Future<Object?> relocate(RelocationDto request) async {
    Object result = Object();
    try{
      result = await repository.relocate(request);
      logger.i("$result");
      // List<dynamic> jsonResponse = result["body"]["events"];
      // List<EventDTO> bodyResponse = [];
      // jsonResponse.map((element) {
      //   bodyResponse.add(EventDTO.fromJson(element));
      // }).toList();
      notifyListeners();
    } on Exception catch(e){
      logger.e(e.toString());
      return result;
    }
    return result;
  }

}