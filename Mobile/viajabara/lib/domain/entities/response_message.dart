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
}