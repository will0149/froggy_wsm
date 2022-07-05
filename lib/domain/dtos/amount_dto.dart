import 'package:flutter/material.dart';

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/01/22
 */

class AmountDTO {
  final String price;
  final String currency;

  AmountDTO({required this.price, required this.currency});

  factory AmountDTO.fromJson(Map<String, dynamic> json) => AmountDTO(
        price: json["price"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {"price": price, "currency": currency};
}
