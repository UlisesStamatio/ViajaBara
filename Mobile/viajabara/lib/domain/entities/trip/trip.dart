import 'package:viajabara/domain/entities/bus/bus.dart';
import 'package:viajabara/domain/entities/stop_over/stop_over.dart';
import 'package:viajabara/domain/entities/trip/filterType.dart';
import 'package:viajabara/domain/entities/user/user.dart';

class TripDto {
  int? id;
  UserDto? driver;
  BusDto? bus;
  DateTime? startTime;
  double? time;
  double? meters;
  String? workDays;
  String? stopovers;
  List<StopOverDto>? listStopovers;
  FilterType? filterType;
  int? enabledSeats;
  double? customPrice;

  TripDto({
    this.id,
    this.driver,
    this.bus,
    this.startTime,
    this.time,
    this.meters,
    this.workDays,
    this.stopovers,
    this.listStopovers,
    this.filterType,
    this.enabledSeats,
    this.customPrice,
  });

  factory TripDto.fromJson(Map<String, dynamic> json) {
    print('Parsing TripDto from JSON: $json');

    List<dynamic>? stopoversJson = json['listStopovers'];
    List<StopOverDto>? listStopovers = stopoversJson != null
        ? stopoversJson
            .map((stopoverJson) => StopOverDto.fromJson(stopoverJson))
            .toList()
        : null;

    return TripDto(
        id: json['id'] as int?,
        driver:
            json['driver'] != null ? UserDto.fromJson(json['driver']) : null,
        bus: json['bus'] != null ? BusDto.fromJson(json['bus']) : null,
        startTime: _parseDateTime(json['startTime']),
        time: json['time'],
        meters: json['meters'],
        workDays: "",
        stopovers: json['stopovers'],
        listStopovers: listStopovers,
        filterType: json['filterType'] != null
            ? FilterTypeExtension.fromValue(json['filterType'])
            : null,
        enabledSeats: json['enabledSeats'] as int?,
        customPrice: json['customPrice']);
  }

  static DateTime? _parseDateTime(dynamic dateTimeValue) {
    if (dateTimeValue is int) {
      return DateTime.fromMillisecondsSinceEpoch(dateTimeValue);
    } else if (dateTimeValue is String) {
      return DateTime.parse(dateTimeValue);
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'driver': driver?.toJson(),
      'bus': bus?.toJson(),
      'startTime': startTime?.toIso8601String(),
      'time': time,
      'meters': meters,
      'workDays': "",
      'stopovers': stopovers,
      'filterType': filterType?.value,
      'enabledSeats': enabledSeats,
      'listStopovers':
          listStopovers?.map((stopover) => stopover.toJson()).toList(),
      'customPrice': customPrice
    };

    print('Generated JSON for TripDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'TripDto{id: $id, driver: $driver, bus: $bus, startTime: $startTime, '
        'time: $time, meters: $meters, workDays: $workDays, stopovers: $stopovers, '
        'filterType: $filterType, enabledSeats: $enabledSeats}';
  }
}
