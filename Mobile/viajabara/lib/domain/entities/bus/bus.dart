class BusDto {
  final int? id;
  final String? image;
  final String? plaque;
  final String? mark;
  final String? model;
  final String? serial;
  final String? fuel;
  final DateTime? createdAt;
  final bool? status;

  BusDto({
    this.id,
    this.image,
    this.plaque,
    this.mark,
    this.model,
    this.serial,
    this.fuel,
    this.createdAt,
    this.status,
  });

  factory BusDto.fromJson(Map<String, dynamic> json) {
    print('Parsing BusDto from JSON: $json');

    return BusDto(
      id: json['id'],
      image: json['image'],
      plaque: json['plaque'],
      mark: json['mark'],
      model: json['model'],
      serial: json['serial'],
      fuel: json['fuel'],
      createdAt: json['create_at'] != null
          ? DateTime.fromMillisecondsSinceEpoch(json['create_at'])
          : null,
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    final jsonMap = {
      'id': id,
      'image': image,
      'plaque': plaque,
      'mark': mark,
      'model': model,
      'serial': serial,
      'fuel': fuel,
      'create_at': createdAt?.toIso8601String(),
      'status': status,
    };

    print('Generated JSON for BusDto: $jsonMap');

    return jsonMap;
  }

  @override
  String toString() {
    return 'BusDto{id: $id, image: $image, plaque: $plaque, mark: $mark, '
        'model: $model, serial: $serial, fuel: $fuel, '
        'createdAt: $createdAt, status: $status}';
  }
}
