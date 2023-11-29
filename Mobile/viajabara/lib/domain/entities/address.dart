class Address {
  int id;
  String description;

  Address({required this.description, required this.id});

  @override
  String toString() {
    return 'Address{id: $id, description: $description}';
  }
}
