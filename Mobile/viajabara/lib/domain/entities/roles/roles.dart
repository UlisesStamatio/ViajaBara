import 'package:flutter/foundation.dart';

class Roles {
  final String? keyRole;
  final String? name;
  final List<Privilege>? privileges;
  final bool? status; 

  Roles({
    this.keyRole,
    this.name,
    this.privileges,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    'keyRole': keyRole,
    'name': name,
    'privileges': privileges,
    'status': status
  };

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      keyRole: json['keyRole'],
      name: json['name'],
      privileges: json['privileges'] != null ? (json['privileges'] as List).map((i) => Privilege.fromJson(i)).toList() : null,
      status: json['status']
    );
  }
}

class Privilege {
  final int? id;
  final String? name;
  final String? description;

  Privilege({ this.id,  this.name,  this.description});

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description
  };

  factory Privilege.fromJson(Map<String, dynamic> json) {
    return Privilege(
      id: json['id'],
      name: json['name'],
      description: json['description']
    );
  }
}


