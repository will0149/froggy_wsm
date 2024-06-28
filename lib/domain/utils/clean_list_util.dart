import 'package:flutter/material.dart';

/**
 * Made for cct_management.
 * By User: josedominguez
 * Date: 06/28/24
 */

class CleanListUtil {

  List<String> cleanList(String value){
    List<String> series = [];
    if(value.contains(" ")){
      series = value.split(" ");
    }
    return series;
  }

}