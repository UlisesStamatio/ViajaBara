import 'package:json_annotation/json_annotation.dart';

part 'book_trip.g.dart';

@JsonSerializable()
class BookTrip {
  String? date;
  int? dutyid;
  int? stateOriginId;
  int? stateDestinyId;
  int? originId;
  int? destinyId;
  int? seats;
  int? tripId;
  String? seatsSelected;
  double? price;
  String? cardNumber;
  String? cvc;

  BookTrip({
    this.date,
    this.dutyid,
    this.stateOriginId,
    this.stateDestinyId,
    this.originId,
    this.destinyId,
    this.seats,
    this.tripId,
    this.seatsSelected,
    this.price,
    this.cardNumber,
    this.cvc,
  });

  @override
  String toString() {
    return 'BookTrip{'
        'date: $date, '
        'dutyid: $dutyid, '
        'stateOriginId: $stateOriginId, '
        'stateDestinyId: $stateDestinyId, '
        'originId: $originId, '
        'destinyId: $destinyId, '
        'seats: $seats, '
        'tripId: $tripId, '
        'seatsSelected: $seatsSelected, '
        'price: $price, '
        'cardNumber: $cardNumber, '
        'cvc: $cvc}';
  }

  factory BookTrip.fromJson(Map<String, dynamic> json) =>
      _$BookTripFromJson(json);

  Map<String, dynamic> toJson() => _$BookTripToJson(this);
}
