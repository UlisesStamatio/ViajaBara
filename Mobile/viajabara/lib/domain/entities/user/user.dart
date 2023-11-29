import 'package:viajabara/domain/entities/person/person.dart';

class UserDto {
  final int? id;
  final String? profile;
  final String? username;
  final String? email;
  final String? password;
  final String? recuperation;
  final DateTime? dateExpiration;
  final DateTime? timeBlocked;
  final bool? changePassword;
  final int? attempts;
  final List<String>? roles;
  final DateTime? createdAt;
  final PersonDto? person;
  final bool? status;

  UserDto({
    this.id,
    this.profile,
    this.username,
    this.email,
    this.password,
    this.recuperation,
    this.dateExpiration,
    this.timeBlocked,
    this.changePassword,
    this.attempts,
    this.roles,
    this.createdAt,
    this.person,
    this.status,
  });
  factory UserDto.fromJson(Map<String, dynamic> json) {
    print('Parsing UserDto from JSON: $json');

    return UserDto(
      id: json['id'],
      profile: json['profile'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      recuperation: json['recuperation'],
      dateExpiration: json['date_expiration'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['date_expiration'])
          : null,
      timeBlocked: json['time_blocked'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['time_blocked'])
          : null,
      changePassword: json['change_password'] ?? false,
      attempts: json['attempts'] ?? 0,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((dynamic item) => item.toString())
              .toList() ??
          [],
      createdAt: json['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['create_at'])
          : null,
      person:
          json['person'] != null ? PersonDto.fromJson(json['person']) : null,
      status: json['status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'profile': profile,
      'username': username,
      'email': email,
      'password': password,
      'recuperation': recuperation,
      'date_expiration': dateExpiration?.toIso8601String(),
      'time_blocked': timeBlocked?.toIso8601String(),
      'change_password': changePassword,
      'attempts': attempts,
      'roles': roles,
      'create_at': createdAt?.toIso8601String(),
      'person': person?.toJson(),
      'status': status,
    };

    print('Generated JSON for UserDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'UserDto{id: $id, profile: $profile, username: $username, email: $email, '
        'password: $password, recuperation: $recuperation, dateExpiration: $dateExpiration, '
        'timeBlocked: $timeBlocked, changePassword: $changePassword, attempts: $attempts, '
        'roles: $roles, createdAt: $createdAt, person: $person, status: $status}';
  }
}
