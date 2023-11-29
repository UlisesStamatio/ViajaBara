import 'package:viajabara/domain/entities/state/state_dto.dart';

class StopOverDto {
  final int? id;
  final String? latitude;
  final String? longitude;
  final String? description;
  final int? sequence;
  final double? meters;
  final double? time;
  final StateDto? state;
  final DateTime? timeAccordingStart;
  StopOverDto({
    this.id,
    this.latitude,
    this.longitude,
    this.description,
    this.sequence,
    this.meters,
    this.time,
    this.state,
    this.timeAccordingStart,
  });

  factory StopOverDto.fromJson(Map<String, dynamic> json) {
    print('Parsing StopOverDto from JSON: $json');

    return StopOverDto(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      sequence: json['sequence'],
      meters: json['meters'],
      time: json['time'],
      state: json['status'] != null ? StateDto.fromJson(json['state']) : null,
      timeAccordingStart: json['timeAccordingStart'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['timeAccordingStart'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'sequence': sequence,
      'meters': meters,
      'time': time,
      'state': state?.toJson(),
      'timeAccordingStart': timeAccordingStart?.toIso8601String(),
    };

    print('Generated JSON for StopOverDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'StopOverDto{id: $id, latitude: $latitude, longitude: $longitude, '
        'description: $description, sequence: $sequence, meters: $meters, '
        'time: $time, state: $state, timeAccordingStart: $timeAccordingStart}';
  }
}
