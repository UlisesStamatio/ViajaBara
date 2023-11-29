// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookTrip _$BookTripFromJson(Map<String, dynamic> json) => BookTrip(
      date: json['date'] as String?,
      dutyid: json['dutyid'] as int?,
      stateOriginId: json['stateOriginId'] as int?,
      stateDestinyId: json['stateDestinyId'] as int?,
      originId: json['originId'] as int?,
      destinyId: json['destinyId'] as int?,
      seats: json['seats'] as int?,
      tripId: json['tripId'] as int?,
      seatsSelected: json['seatsSelected'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      cardNumber: json['cardNumber'] as String?,
      cvc: json['cvc'] as String?,
    );

Map<String, dynamic> _$BookTripToJson(BookTrip instance) => <String, dynamic>{
      'date': instance.date,
      'dutyid': instance.dutyid,
      'stateOriginId': instance.stateOriginId,
      'stateDestinyId': instance.stateDestinyId,
      'originId': instance.originId,
      'destinyId': instance.destinyId,
      'seats': instance.seats,
      'tripId': instance.tripId,
      'seatsSelected': instance.seatsSelected,
      'price': instance.price,
      'cardNumber': instance.cardNumber,
      'cvc': instance.cvc,
    };
