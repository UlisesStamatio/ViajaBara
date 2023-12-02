class VisualConfigDto {
  int? id;
  String? backgroundAside;
  String? textAside;
  String? logo;
  double? kilometerPrice;

  VisualConfigDto.empty();

  VisualConfigDto({
    this.id,
    this.backgroundAside,
    this.textAside,
    this.logo,
    this.kilometerPrice,
  });

  factory VisualConfigDto.fromJson(Map<String, dynamic> json) {
    return VisualConfigDto(
      id: json['id'] as int?,
      backgroundAside: json['backgroundAside'] as String?,
      textAside: json['textAside'] as String?,
      logo: json['logo'] as String?,
      kilometerPrice: json['kilometerPrice']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'backgroundAside': backgroundAside,
      'textAside': textAside,
      'logo': logo,
      'kilometerPrice': kilometerPrice,
    };
  }

  @override
  String toString() {
    return 'VisualConfigDto{id: $id, backgroundAside: $backgroundAside, textAside: $textAside, '
        'logo: $logo, kilometerPrice: $kilometerPrice}';
  }
}
