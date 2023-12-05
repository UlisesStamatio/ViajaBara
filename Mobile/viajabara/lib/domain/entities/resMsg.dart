import 'package:viajabara/domain/entities/roles/roles.dart';

class ResMsg{
  final int? id;
  final String? token;
  final String? email;
  final String? profile;
  final String? name;
  final String? cellphone;
  final String? birthDate;
  final String? sex;
  final String? state;
  final Roles? roles;
  final String? text;
  final String? type;

  ResMsg({
      this.id,
      this.token,
      this.email, 
      this.profile,
      this.name, 
      this.cellphone,
      this.birthDate,
      this.sex,
      this.state,
      this.roles,
      this.text,
      this.type
    });

  Map<String, dynamic> toJson() => {
    'id': id,
    'token': token,
    'email': email,
    'name': name,
    'cellphone': cellphone,
    'birthDate': birthDate,
    'sex':sex,
    'state': state,
    'roles': roles,
    'text': text,
    'type': type
  };

  factory ResMsg.fromJson(Map<String, dynamic> json) {
    return ResMsg(
      id: json['id'],
      token: json['token'],
      email: json['email'],
      name: json['name'],
      cellphone: json['cellphone'],
      birthDate: json['birthDate'],
      sex: json['sex'],
      state: json['state'],
      roles: json['roles'] != null ? Roles.fromJson(json['roles']) : null,
      text: json['text'],
      type: json['type']
    );
  }
}