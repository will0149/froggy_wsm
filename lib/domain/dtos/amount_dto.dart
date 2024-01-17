

/**
 * Made for parkea.
 * By User: josedominguez
 * Date: 07/01/22
 */

class AmountDTO {
  String price;
  final String currency;

  AmountDTO({this.price = "0.0", required this.currency});

  factory AmountDTO.fromJson(Map<String, dynamic> json) => AmountDTO(
        price: json["price"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {"price": price, "currency": currency};
}
