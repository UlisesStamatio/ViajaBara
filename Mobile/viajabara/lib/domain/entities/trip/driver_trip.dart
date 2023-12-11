import 'dart:convert';

import 'package:intl/intl.dart';

class DriverTrip {
  final int? id;
  final TripDetail? trip;
  final String? startDate;
  final String? createdAt;
  final int? status;
  final int? enableSeats;

  DriverTrip({
    this.id,
    this.trip,
    this.startDate,
    this.createdAt,
    this.status,
    this.enableSeats,
  });

  factory DriverTrip.fromJson(Map<String, dynamic> json) {
    return DriverTrip(
      id: json['id'],
      trip: TripDetail.fromJson(json['trip']),
      startDate:
          formatDate(DateTime.fromMillisecondsSinceEpoch(json['startDate'])),
      createdAt:
          formatDate(DateTime.fromMillisecondsSinceEpoch(json['createdAt'])),
      status: json['status'],
      enableSeats: json['enableSeats'],
    );
  }
}

class TripDetail {
  final int? id;
  final Driver? driver;
  final Bus? bus;
  final DateTime? createdAt;
  final bool? status;
  final double? meters;
  final double? time;
  final String? startTime;
  final List<String>? workDays;
  final List<StopOver>? stopOvers;

  TripDetail({
    this.id,
    this.driver,
    this.bus,
    this.createdAt,
    this.status,
    this.meters,
    this.time,
    this.startTime,
    this.workDays,
    this.stopOvers,
  });

  factory TripDetail.fromJson(Map<String, dynamic> json) {
    return TripDetail(
      id: json['id'],
      driver: Driver.fromJson(json['driver']),
      bus: Bus.fromJson(json['bus']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      status: json['status'],
      meters: json['meters'],
      time: json['time'],
      startTime:
          formatTime(DateTime.fromMillisecondsSinceEpoch((json['startTime']))),
      workDays: json['workDays'] != null
          ? List<String>.from(jsonDecode(json['workDays']))
          : [],
      stopOvers: json['stopovers'] != null
          ? List<StopOver>.from(
              jsonDecode(json['stopovers']).map((i) => StopOver.fromJson(i)))
          : [],
    );
  }
}

class Driver {
  final int? id;
  final String? username;
  final String? email;

  Driver({this.id, this.username, this.email});

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class Bus {
  final int? id;
  final String? plaque;
  final String? mark;

  Bus({this.id, this.plaque, this.mark});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      plaque: json['plaque'],
      mark: json['mark'],
    );
  }
}

class StopOver {
  final int? id;
  final int? meters;
  final int? time;
  final bool? status;
  final Address? address;
  final int? sequence;
  final DateTime? createdAt;

  StopOver(
      {this.id,
      this.meters,
      this.time,
      this.status,
      this.address,
      this.sequence,
      this.createdAt});

  factory StopOver.fromJson(Map<String, dynamic> json) {
    return StopOver(
      id: json['id'],
      meters: json['meters'],
      time: json['time'],
      status: json['status'],
      address: Address.fromJson(json['address']),
      sequence: json['sequence'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
    );
  }
}

class Address {
  final int? id;
  final String? latitude;
  final String? longitude;
  final String? description;
  final String? state;

  Address({
    this.id,
    this.latitude,
    this.longitude,
    this.description,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      state: json['state']['name'],
    );
  }
}


String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}
