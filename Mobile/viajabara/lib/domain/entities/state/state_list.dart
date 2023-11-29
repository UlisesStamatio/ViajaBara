import 'package:viajabara/domain/entities/address.dart';

class StateList {
  int id;
  String name;
  List<Address> addresses;

  StateList({required this.name, required this.id, required this.addresses});

  @override
  String toString() {
    return 'StateList{id: $id, name: $name, addresses: $addresses}';
  }
}
