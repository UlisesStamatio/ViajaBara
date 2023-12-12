import 'package:flutter/material.dart';
import 'package:viajabara/domain/entities/book_trip.dart';

class BookTripsDataSource extends DataTableSource {
  final BookTrip _bookTrip;
  final List<DataRow> _rows;

  BookTripsDataSource(this._bookTrip, this._rows);

  @override
  DataRow? getRow(int index) {
    if (index >= _rows.length) {
      return null;
    }
    return _rows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _bookTrip.seats!;

  @override
  int get selectedRowCount => 0;
}
