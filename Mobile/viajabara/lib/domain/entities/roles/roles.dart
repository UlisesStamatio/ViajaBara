class Roles {
  final String? keyRole;
  final String? name;
  final List<Privilege>? privileges;
  final bool? status; 

  Roles({
    required this.keyRole,
    required this.name,
    this.privileges,
    required this.status,
  });
}

class Privilege {
  final int? id;
  final String? name;
  final String? description;

  Privilege({ this.id,  this.name,  this.description});
}


