class Roles {
  final String? keyRole;
  final String? name;
  final bool? status; 

  Roles({
    this.keyRole,
    this.name,
    this.status,
  });

  Map<String, dynamic> toJson() => {
    'keyRole': keyRole,
    'name': name,
    'status': status
  };

  factory Roles.fromJson(Map<String, dynamic> json) {
    return Roles(
      keyRole: json['keyRole'],
      name: json['name'],
      status: json['status']
    );
  }
}
