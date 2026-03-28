import 'package:json_annotation/json_annotation.dart';

part 'user_ticket_dto.g.dart';

@JsonSerializable()
class UserTicketDTO {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'ticket_code')
  final String? ticketCode;
  @JsonKey(name: 'event_name')
  final String? eventName;
  @JsonKey(name: 'event_date')
  final String? eventDate;
  @JsonKey(name: 'banner_img')
  final String? bannerUrl;
  @JsonKey(name: 'place')
  final String? place;
  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'total_amount')
  final String? totalAmount;
  @JsonKey(name: 'currency')
  final String? currency;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'date_purchased')
  final String? datePurchased;

  const UserTicketDTO({
    this.id,
    this.ticketCode,
    this.eventName,
    this.eventDate,
    this.bannerUrl,
    this.place,
    this.quantity,
    this.totalAmount,
    this.currency,
    this.status,
    this.datePurchased,
  });

  factory UserTicketDTO.fromJson(Map<String, dynamic> json) =>
      _$UserTicketDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserTicketDTOToJson(this);
}
