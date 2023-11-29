import 'package:viajabara/domain/entities/state/state_dto.dart';

class PersonDto {
  final int? id;
  final String name;
  final String surname;
  final String? cellphone;
  final String sex;
  final DateTime? birthDate;
  final StateDto? state;
  final DateTime? createdAt;
  final bool? status;

  PersonDto({
    this.id,
    required this.name,
    required this.surname,
    this.cellphone,
    required this.sex,
    this.birthDate,
    this.state,
    this.createdAt,
    this.status,
  });

  factory PersonDto.fromJson(Map<String, dynamic> json) {
    print('Parsing PersonDto from JSON: $json');

    return PersonDto(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      cellphone: json['cellphone'],
      sex: json['sex'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      state: json['state'] != null ? StateDto.fromJson(json['state']) : null,
      createdAt:
          json['create_at'] != null ? DateTime.parse(json['create_at']) : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'name': name,
      'surname': surname,
      'cellphone': cellphone,
      'sex': sex,
      'birth_date': birthDate?.toIso8601String(),
      'state': state?.toJson(),
      'create_at': createdAt?.toIso8601String(),
      'status': status,
    };

    print('Generated JSON for PersonDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'PersonDto{id: $id, name: $name, surname: $surname, '
        'cellphone: $cellphone, sex: $sex, birthDate: $birthDate, '
        'state: $state, createdAt: $createdAt, status: $status}';
  }
}
