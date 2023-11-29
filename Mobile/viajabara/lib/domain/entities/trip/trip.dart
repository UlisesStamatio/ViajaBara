import 'package:viajabara/domain/entities/bus/bus.dart';
import 'package:viajabara/domain/entities/route/route.dart';
import 'package:viajabara/domain/entities/trip/filterType.dart';
import 'package:viajabara/domain/entities/user/user.dart';

class TripDto {
  int? id;
  UserDto? driver;
  BusDto? bus;
  DateTime? startTime;
  String? workDays;
  RouteDto? route;
  FilterType? filterType;

  TripDto({
    this.id,
    this.driver,
    this.bus,
    this.startTime,
    this.workDays,
    this.route,
    this.filterType,
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
      workDays: "",
      route: json['route'] != null ? RouteDto.fromJson(json['route']) : null,
      filterType: json['filterType'] != null
          ? FilterTypeExtension.fromValue(json['filterType'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'driver': driver?.toJson(),
      'bus': bus?.toJson(),
      'startTime': startTime?.toIso8601String(),
      'workDays': "",
      'route': route?.toJson(),
      'filterType': filterType?.value,
    };

    print('Generated JSON for TripDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'TripDto{id: $id, driver: $driver, bus: $bus, startTime: $startTime, '
        'workDays: $workDays, route: $route, filterType: $filterType}';
  }
}
