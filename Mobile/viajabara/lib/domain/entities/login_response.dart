import 'package:viajabara/domain/entities/roles/roles.dart';

class LoginResponse{
  final String? token;
  final String? email;
  final String? name;
  final Roles? roles;
  final String? text;
  final String? type;

  LoginResponse({
      this.token,
      this.email, 
      this.name, 
      this.roles,
      this.text,
      this.type
    });
}