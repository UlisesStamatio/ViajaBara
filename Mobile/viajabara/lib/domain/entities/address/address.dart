import 'package:viajabara/domain/entities/state/state_dto.dart';

class AddressDto {
  final int? id;
  final String? latitude;
  final String? longitude;
  final String? description;
  final StateDto? state;
  final DateTime? createdAt;

  AddressDto({
    this.id,
    this.latitude,
    this.longitude,
    this.description,
    this.state,
    this.createdAt,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) {
    print('Parsing AddressDto from JSON: $json');

    return AddressDto(
      id: json['id'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      state: json['state'] != null ? StateDto.fromJson(json['state']) : null,
      createdAt: json['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['create_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'state': state?.toJson(),
      'create_at': createdAt?.toIso8601String(),
    };

    print('Generated JSON for AddressDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'AddressDto{id: $id, latitude: $latitude, longitude: $longitude, '
        'description: $description, state: $state, createdAt: $createdAt}';
  }
}
