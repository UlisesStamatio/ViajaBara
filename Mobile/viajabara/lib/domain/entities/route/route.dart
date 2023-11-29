import 'package:viajabara/domain/entities/address/address.dart';
import 'package:viajabara/domain/entities/stop_over/stop_over.dart';

class RouteDto {
  final int? id;
  final AddressDto? startAddress;
  final AddressDto? endAddress;
  final double? meters;
  final double? time;
  final DateTime? createdAt;
  final bool? status;
  final List<StopOverDto>? stopOvers;

  RouteDto({
    this.id,
    this.startAddress,
    this.endAddress,
    this.meters,
    this.time,
    this.createdAt,
    this.status,
    this.stopOvers,
  });

  factory RouteDto.fromJson(Map<String, dynamic> json) {
    print('Parsing RouteDto from JSON: $json');

    return RouteDto(
      id: json['id'],
      startAddress: json['startAddress'] != null
          ? AddressDto.fromJson(json['startAddress'])
          : null,
      endAddress: json['endAddress'] != null
          ? AddressDto.fromJson(json['endAddress'])
          : null,
      meters: json['meters'],
      time: json['time'],
      createdAt: json['created_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['create_at'])
          : null,
      status: json['status'],
      stopOvers: json['stopOvers'] != null
          ? (json['stopOvers'] as List)
              .map((stopOver) => StopOverDto.fromJson(stopOver))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'startAddress': startAddress?.toJson(),
      'endAddress': endAddress?.toJson(),
      'distance_meters': meters,
      'distance_time': time,
      'create_at': createdAt?.toIso8601String(),
      'status': status,
      'stopOvers': stopOvers?.map((stopOver) => stopOver.toJson()).toList(),
    };

    print('Generated JSON for RouteDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'RouteDto{id: $id, startAddress: $startAddress, endAddress: $endAddress, '
        'meters: $meters, time: $time, createdAt: $createdAt, status: $status, '
        'stopOvers: $stopOvers}';
  }
}
