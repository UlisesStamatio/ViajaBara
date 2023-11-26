import 'package:viajabara/domain/entities/roles/roles.dart';

class ResponseMessage{
  final String? token;
  final String? email;
  final String? name;
  final Roles? roles;
  final String? text;
  final String? type;

  ResponseMessage({
      this.token,
      this.email, 
      this.name, 
      this.roles,
      this.text,
      this.type
    });

  Map<String, dynamic> toJson() => {
    'token': token,
    'email': email,
    'name': name,
    'roles': roles,
    'text': text,
    'type': type
  };

  factory ResponseMessage.fromJson(Map<String, dynamic> json) {
    return ResponseMessage(
      token: json['token'],
      email: json['email'],
      name: json['name'],
      roles: Roles.fromJson(json['roles']),
      text: json['text'],
      type: json['type']
    );
  }
}