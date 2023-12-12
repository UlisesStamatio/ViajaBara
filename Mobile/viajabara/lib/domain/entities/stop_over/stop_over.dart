import 'package:viajabara/domain/entities/address/address.dart';
import 'package:viajabara/domain/entities/state/state_dto.dart';

class StopOverDto {
  final int? id;
  final AddressDto?
      addressDto; // Considerando que AddressDto es un DTO separado
  final String? description;
  final StateDto? state;
  final int sequence;
  final double meters;
  final double time;
  final DateTime? timeAccordingStart;

  StopOverDto({
    this.id,
    this.addressDto,
    this.description,
    this.state,
    required this.sequence,
    required this.meters,
    required this.time,
    required this.timeAccordingStart,
  });

  factory StopOverDto.fromJson(Map<String, dynamic> json) {
    print('Parsing StopOverDto from JSON: $json');

    return StopOverDto(
        id: json['id'],
        addressDto: json['addressDto'] != null
            ? AddressDto.fromJson(json['addressDto'])
            : null,
        description: json['description'],
        state: json['state'] != null ? StateDto.fromJson(json['state']) : null,
        sequence: json['sequence'],
        meters: json['meters'],
        time: json['time'],
        timeAccordingStart: _parseDateTime(json['timeAccordingStart']));
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
      'addressDto': addressDto?.toJson(),
      'description': description,
      'state': state?.toJson(),
      'sequence': sequence,
      'meters': meters,
      'time': time,
      'timeAccordingStart': timeAccordingStart?.toIso8601String(),
    };

    print('Generated JSON for StopOverDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'StopOverDto{id: $id, addressDto: $addressDto, description: $description, '
        'state: $state, sequence: $sequence, meters: $meters, time: $time, '
        'timeAccordingStart: $timeAccordingStart}';
  }
}
