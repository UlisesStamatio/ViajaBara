class PaymentMethodDart {
  final int? id;
  final String? name;
  final String? apikey;

  PaymentMethodDart({
    this.id,
    this.name,
    this.apikey,
  });

  factory PaymentMethodDart.fromJson(Map<String, dynamic> json) {
    return PaymentMethodDart(
      id: json['id'],
      name: json['name'],
      apikey: json['apikey'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'apikey': apikey,
    };
  }

  @override
  String toString() {
    return 'PaymentMethod{id: $id, name: $name, apikey: $apikey}';
  }
}
