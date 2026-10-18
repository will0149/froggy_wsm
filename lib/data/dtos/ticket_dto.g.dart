// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketDTO _$TicketDTOFromJson(Map<String, dynamic> json) => TicketDTO(
      id: (json['id'] as num).toInt(),
      event: EventDTO.fromJson(json['event'] as Map<String, dynamic>),
      datePurchased: json['date_purchased'] as String?,
      code: json['code'] as String?,
      status: json['status'] as String?,
      pricePaid: json['price_paid'] as String?,
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$TicketDTOToJson(TicketDTO instance) => <String, dynamic>{
      'id': instance.id,
      'event': instance.event.toJson(),
      'date_purchased': instance.datePurchased,
      'code': instance.code,
      'status': instance.status,
      'price_paid': instance.pricePaid,
      'currency': instance.currency,
    };
