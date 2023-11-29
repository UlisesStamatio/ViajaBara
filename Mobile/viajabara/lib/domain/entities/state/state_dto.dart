class StateDto {
  final int? id;
  final String? name;
  final bool? status;
  final DateTime? createdAt;

  StateDto({
    this.id,
    this.name,
    this.status,
    this.createdAt,
  });
  @override
  String toString() {
    return 'StateDto{id: $id, name: $name, status: $status, createdAt: $createdAt}';
  }

  factory StateDto.fromJson(Map<String, dynamic> json) {
    print('Parsing StateDto from JSON: $json');

    return StateDto(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      createdAt: json['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['create_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'name': name,
      'status': status,
      'create_at': createdAt?.toIso8601String(),
    };

    print('Generated JSON for StateDto: $jsonMap');

    return jsonMap;
  }
}
