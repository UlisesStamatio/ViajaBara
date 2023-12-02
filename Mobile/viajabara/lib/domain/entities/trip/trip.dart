import 'package:viajabara/domain/entities/bus/bus.dart';
import 'package:viajabara/domain/entities/route/route.dart';
import 'package:viajabara/domain/entities/trip/filterType.dart';
import 'package:viajabara/domain/entities/user/user.dart';

class TripDto {
  int? id;
  UserDto? driver;
  BusDto? bus;
  DateTime? startTime;
  DateTime? endTime;
  String? workDays;
  RouteDto? route;
  FilterType? filterType;
  int? enabledSeats;

  TripDto({
    this.id,
    this.driver,
    this.bus,
    this.startTime,
    this.endTime,
    this.workDays,
    this.route,
    this.filterType,
    this.enabledSeats,
  });

  factory TripDto.fromJson(Map<String, dynamic> json) {
    print('Parsing TripDto from JSON: $json');

    return TripDto(
      id: json['id'] as int?,
      driver: json['driver'] != null ? UserDto.fromJson(json['driver']) : null,
      bus: json['bus'] != null ? BusDto.fromJson(json['bus']) : null,
      startTime: json['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['startTime'])
          : null,
      endTime: json['endTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['endTime'])
          : null,
      workDays: "",
      route: json['route'] != null ? RouteDto.fromJson(json['route']) : null,
      filterType: json['filterType'] != null
          ? FilterTypeExtension.fromValue(json['filterType'])
          : null,
      enabledSeats: json['enabledSeats'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'driver': driver?.toJson(),
      'bus': bus?.toJson(),
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
      'workDays': "",
      'route': route?.toJson(),
      'filterType': filterType?.value,
      'enabledSeats': enabledSeats,
    };

    print('Generated JSON for TripDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'TripDto{id: $id, driver: $driver, bus: $bus, startTime: $startTime, endTime: $endTime, '
        'workDays: $workDays, route: $route, filterType: $filterType, enabledSeats: $enabledSeats}';
  }
}
