import 'dart:convert';
import 'package:intl/intl.dart';

class RidersTrip {
  final int? id;
  final StartAddress? startAddress;
  final EndAddress? endAddress;
  final double? cost;
  final Client? client;
  final int? checked;
  final List<String>? seatsSelected;
  final int? wholeTrip;
  final String? startTime;  

  RidersTrip({
    this.id,
    this.startAddress,
    this.endAddress,
    this.cost,
    this.client,
    this.checked,
    this.seatsSelected,
    this.wholeTrip,
    this.startTime,
  });

  factory RidersTrip.fromJson(Map<String, dynamic> json) {
    return RidersTrip(
      id: json['id'],
      startAddress: json['startAddress'] != null
          ? StartAddress.fromJson(json['startAddress'])
          : null,
      endAddress: json['endAddress'] != null
          ? EndAddress.fromJson(json['endAddress'])
          : null,
      cost: json['cost'],
      client: json['client'] != null ? Client.fromJson(json['client']) : null,
      checked: json['checked'],
      seatsSelected: json['seatsSelected'] != null
          ? List<String>.from(jsonDecode(json['seatsSelected']))
          : null,
      wholeTrip: json['wholeTrip'],
      startTime: formatTime(DateTime.fromMillisecondsSinceEpoch(
          json['openTrips']['trip']['startTime'])),
    );
  }
}

class Client {
  final int? id;
  final String? name;
  final String? surname;
  final String? profile;
  final String? cellphone;
  final String? email;
  final String? username;

  Client({
    this.id,
    this.name,
    this.surname,
    this.profile,
    this.cellphone,
    this.email,
    this.username,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      name: json['person']['name'],
      surname: json['person']['surname'],
      profile: json['profile'],
      cellphone: json['person']['cellphone'],
      email: json['email'],
      username: json['username'],
    );
  }
}

class EndAddress {
  final int? id;
  final String? description;
  final String? state;

  EndAddress({
    this.id,
    this.description,
    this.state,
  });

  factory EndAddress.fromJson(Map<String, dynamic> json) {
    return EndAddress(
      id: json['id'],
      description: json['description'],
      state: json['state']['name'],
    );
  }
}

class StartAddress {
  final int? id;
  final String? description;
  final String? state;

  StartAddress({
    this.id,
    this.description,
    this.state,
  });

  factory StartAddress.fromJson(Map<String, dynamic> json) {
    return StartAddress(
      id: json['id'],
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