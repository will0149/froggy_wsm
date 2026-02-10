// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_purchase_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketPurchaseDTO _$TicketPurchaseDTOFromJson(Map<String, dynamic> json) =>
    TicketPurchaseDTO(
      eventId: json['event_id'] as String,
      quantity: (json['quantity'] as num).toInt(),
      customerName: json['customer_name'] as String,
      customerEmail: json['customer_email'] as String,
      totalAmount: json['total_amount'] as String,
      currency: json['currency'] as String,
    );

Map<String, dynamic> _$TicketPurchaseDTOToJson(TicketPurchaseDTO instance) =>
    <String, dynamic>{
      'event_id': instance.eventId,
      'quantity': instance.quantity,
      'customer_name': instance.customerName,
      'customer_email': instance.customerEmail,
      'total_amount': instance.totalAmount,
      'currency': instance.currency,
    };
