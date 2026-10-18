// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendeeDTO _$AttendeeDTOFromJson(Map<String, dynamic> json) => AttendeeDTO(
      ticketId: (json['id'] as num).toInt(),
      username: AttendeeDTO._readCustomer(json, 'username') as String,
      eventId: (AttendeeDTO._readEventId(json, 'event') as num?)?.toInt(),
      status: json['status'] as String?,
      datePurchased: json['date_purchased'] as String?,
      firstName: AttendeeDTO._readCustomer(json, 'first_name') as String?,
      lastName: AttendeeDTO._readCustomer(json, 'last_name') as String?,
      avatarUrl: ApiPathsEnums.absoluteUrl(
          AttendeeDTO._readCustomer(json, 'avatar') as String?),
    );
