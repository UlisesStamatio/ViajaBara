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
      startDate: formatDate(DateTime.fromMillisecondsSinceEpoch(json['startDate'])),
      createdAt: formatDate(DateTime.fromMillisecondsSinceEpoch(json['createdAt'])),
      status: json['status'],
      enableSeats: json['enableSeats'],
    );
  }
}

class TripDetail {
  final int? id;
  final Driver? driver;
  final Bus? bus;
  final Route? route;
  final DateTime? createdAt;
  final bool? status;
  final String? startTime;
  final List<String>? workDays;

  TripDetail({
    this.id,
    this.driver,
    this.bus,
    this.route,
    this.createdAt,
    this.status,
    this.startTime,
    this.workDays,
  });

  factory TripDetail.fromJson(Map<String, dynamic> json) {
    return TripDetail(
      id: json['id'],
      driver: Driver.fromJson(json['driver']),
      bus: Bus.fromJson(json['bus']),
      route: Route.fromJson(json['route']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      status: json['status'],
      startTime: formatTime(DateTime.fromMillisecondsSinceEpoch((json['startTime']))),
      workDays: json['workDays'] != null
          ? List<String>.from(jsonDecode(json['workDays']))
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

class Route {
  final int? id;
  final String? name;
  final double? meters;
  final double? time;
  final DateTime? createdAt;
  final bool? status;
  final List<StopOver>? stopOvers;

  Route({
    this.id,
    this.name,
    this.meters,
    this.time,
    this.createdAt,
    this.status,
    this.stopOvers,
  });

  factory Route.fromJson(Map<String, dynamic> json) {
    return Route(
      id: json['id'],
      name: json['name'],
      meters: json['meters'],
      time: json['time'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['createdAt']),
      status: json['status'],
      stopOvers: (json['stopOvers'] as List).map((i) => StopOver.fromJson(i)).toList(),
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

class StopOver {
  int? id;
  Address? address;
  int? sequence;
  double? meters;
  double? time;
  int? createdAt;
  bool? status;

  StopOver({this.id, this.address, this.sequence, this.meters, this.time, this.createdAt, this.status});

  factory StopOver.fromJson(Map<String, dynamic> json) {
    return StopOver(
      id: json['id'],
      address: Address.fromJson(json['address']),
      sequence: json['sequence'],
      meters: json['meters'],
      time: json['time'],
      createdAt: json['createdAt'],
      status: json['status'],
    );
  }
}

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}