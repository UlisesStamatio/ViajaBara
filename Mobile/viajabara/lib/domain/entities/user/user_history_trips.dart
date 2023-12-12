import 'dart:convert';
import 'package:intl/intl.dart';

class HistoryClientTrip {
  final int? id;
  final Address? startAddress;
  final Address? endAddress;
  final double? cost;
  final int? checked;
  final String? seatsSelected;
  final int? wholeTrip;
  final String? profileImageDriver;
  final String? nameDriver;
  final String? startDate;
  final Trip? trip;
  final int? stateTrip;

  HistoryClientTrip({
    this.id,
    this.startAddress,
    this.endAddress,
    this.cost,
    this.checked,
    this.seatsSelected,
    this.wholeTrip,
    this.profileImageDriver,
    this.nameDriver,
    this.startDate,
    this.trip,
    this.stateTrip,
  });

  factory HistoryClientTrip.fromJson(Map<String, dynamic> json) =>
      HistoryClientTrip(
        id: json['id'],
        startAddress: Address.fromJson(json['startAddress']),
        endAddress: Address.fromJson(json['endAddress']),
        cost: json['cost'],
        checked: json['checked'],
        seatsSelected: json['seatsSelected'],
        wholeTrip: json['wholeTrip'],
        profileImageDriver: json['openTrips']['trip']['driver']['profile'],
        nameDriver: json['openTrips']['trip']['driver']['username'],
        startDate: formatDate(DateTime.fromMillisecondsSinceEpoch(
            json['openTrips']['startDate'])),
        trip: Trip.fromJson(json['openTrips']['trip']),
        stateTrip: json['openTrips']['status'],
      );
}

class Address {
  final int? id;
  final String? description;
  final String? latitude;
  final String? longitude;
  final int? createdAt;
  final String? state;

  Address({
    this.id,
    this.description,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.state,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        description: json['description'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        createdAt: json['createdAt'],
        state: json['state']['name'],
      );
}

class Trip {
  final int? id;
  final bool? status;
  final double? meters;
  final double? time;
  final Bus? bus;
  final String? startTime;
  final List<String>? workDays;
  final List<StopOver>? stopOvers;

  Trip({
    this.id,
    this.status,
    this.meters,
    this.time,
    this.bus,
    this.startTime,
    this.workDays,
    this.stopOvers,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    return Trip(
      id: json['id'],
      status: json['status'],
      meters: json['meters'],
      time: json['time'],
      bus: Bus.fromJson(json['bus']),
      startTime:
          formatTime(DateTime.fromMillisecondsSinceEpoch(json['startTime'])),
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

class Bus {
  final int? id;
  final String? plaque;
  final String? mark;
  final String? model;

  Bus({this.id, this.plaque, this.mark, this.model});

  factory Bus.fromJson(Map<String, dynamic> json) {
    return Bus(
      id: json['id'],
      plaque: json['plaque'],
      mark: json['mark'],
      model: json['model'],
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

String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}
