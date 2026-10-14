// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketDTO _$TicketDTOFromJson(Map<String, dynamic> json) => TicketDTO(
      id: (json['id'] as num).toInt(),
      event: EventDTO.fromJson(json['event'] as Map<String, dynamic>),
      datePurchased: json['date_purchased'] as String?,
    );

Map<String, dynamic> _$TicketDTOToJson(TicketDTO instance) => <String, dynamic>{
      'id': instance.id,
      'event': instance.event.toJson(),
      'date_purchased': instance.datePurchased,
    };
