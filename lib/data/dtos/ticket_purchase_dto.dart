import 'package:json_annotation/json_annotation.dart';

part 'ticket_purchase_dto.g.dart';

@JsonSerializable()
class TicketPurchaseDTO {
  @JsonKey(name: 'event_id')
  final String eventId;
  @JsonKey(name: 'quantity')
  final int quantity;
  @JsonKey(name: 'customer_name')
  final String customerName;
  @JsonKey(name: 'customer_email')
  final String customerEmail;
  @JsonKey(name: 'total_amount')
  final String totalAmount;
  @JsonKey(name: 'currency')
  final String currency;

  TicketPurchaseDTO({
    required this.eventId,
    required this.quantity,
    required this.customerName,
    required this.customerEmail,
    required this.totalAmount,
    required this.currency,
  });

  factory TicketPurchaseDTO.fromJson(Map<String, dynamic> json) =>
      _$TicketPurchaseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TicketPurchaseDTOToJson(this);
}
