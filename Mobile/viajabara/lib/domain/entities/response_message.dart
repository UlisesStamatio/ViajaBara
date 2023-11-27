import 'package:viajabara/domain/entities/roles/roles.dart';

class ResponseMessage{
  final String? token;
  final String? email;
  final String? name;
  final String? cellphone;
  final String? birthDate;
  final String? sex;
  final Roles? roles;
  final String? text;
  final String? type;

  ResponseMessage({
      this.token,
      this.email, 
      this.name, 
      this.cellphone,
      this.birthDate,
      this.sex,
      this.roles,
      this.text,
      this.type
    });

  Map<String, dynamic> toJson() => {
    'token': token,
    'email': email,
    'name': name,
    'cellphone': cellphone,
    'birthDate': birthDate,
    'sex':sex,
    'roles': roles,
    'text': text,
    'type': type
  };

  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(
      token: json['token'],
      email: json['email'],
      name: json['name'],
      cellphone: json['cellphone'],
      birthDate: json['birthDate'],
      sex: json['sex'],
      roles: Roles.fromJson(json['roles']),
      text: json['text'],
      type: json['type']
    );
  }
}