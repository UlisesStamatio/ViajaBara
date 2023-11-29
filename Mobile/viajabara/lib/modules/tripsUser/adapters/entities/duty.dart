class DutyItem {
  int id;
  String name;

  DutyItem({required this.name, required this.id});

  @override
  String toString() {
    return 'DutyItem{name: $name, id: $id}';
  }
}
