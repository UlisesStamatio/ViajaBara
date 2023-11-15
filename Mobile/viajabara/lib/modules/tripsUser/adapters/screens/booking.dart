import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final _formKey = GlobalKey<FormState>();
  int _rowsPerPage = 3;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  Set<SeatNumber> selectedSeats = Set();
  List<MapEntry<String, int>> patternList = const [
    // 1 fila
    MapEntry("[0][0]", 4),
    MapEntry("[0][1]", 3),
    MapEntry("[0][2]", 2),
    MapEntry("[0][3]", 1),
    // 2 fila
    MapEntry("[1][0]", 7),
    MapEntry("[1][1]", 0),
    MapEntry("[1][2]", 6),
    MapEntry("[1][3]", 5),
    // 3 fila
    MapEntry("[2][0]", 10),
    MapEntry("[2][1]", 0),
    MapEntry("[2][2]", 9),
    MapEntry("[2][3]", 8),
    // 4 fila
    MapEntry("[3][0]", 13),
    MapEntry("[3][1]", 0),
    MapEntry("[3][2]", 12),
    MapEntry("[3][3]", 11),
    // 5 fila
    MapEntry("[4][0]", 16),
    MapEntry("[4][1]", 0),
    MapEntry("[4][2]", 15),
    MapEntry("[4][3]", 14),
    // 6 fila
    MapEntry("[5][0]", 0),
    MapEntry("[5][1]", 19),
    MapEntry("[5][2]", 18),
    MapEntry("[5][3]", 17),
    // 7 fila
    MapEntry("[6][0]", 0),
    MapEntry("[6][1]", 20),
    MapEntry("[6][2]", 0),
    MapEntry("[6][3]", 0),
  ];

  @override
  Widget build(BuildContext context) {
    List<DataRow> _dataRows = List.generate(
      100, // Número total de filas
      (index) {
        return DataRow(
          cells: [
            DataCell(Text('Seat $index')),
            DataCell(Text('Destino $index')),
          ],
        );
      },
    );

    return Scaffold(
        appBar: AppBar(
          title: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Reservar',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )),
          foregroundColor: ColorsApp.muted,
          actions: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SvgPicture.asset(StuffApp.logoViajabara, height: 35),
            ),
          ],
          backgroundColor: ColorsApp.whiteColor,
          shadowColor: ColorsApp.blackColor,
          elevation: 2,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorsApp.primayColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
          SvgPicture.asset(
            StuffApp.bgGeneral,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Form(
                  key: _formKey,
                  onChanged: () {
                    // setState(() {
                    //   _isButtonDisabled =
                    //       !_formKey.currentState!.validate();
                    // });
                  },
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(children: <Widget>[
                            const SizedBox(
                              height: 10,
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              label: const Text('Detalles'),
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  foregroundColor: ColorsApp.whiteColor,
                                  backgroundColor: ColorsApp.primayColor,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width / 1.5,
                                    0,
                                  )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            // ************

                            PaginatedDataTable(
                              rowsPerPage: _rowsPerPage,
                              onRowsPerPageChanged: (int? value) {
                                if (value == null) return;
                                setState(() {
                                  _rowsPerPage = value;
                                });
                              },
                              availableRowsPerPage: [3, 5, 10, 20],
                              sortColumnIndex: _sortColumnIndex,
                              sortAscending: _sortAscending,
                              columns: [
                                DataColumn(
                                  label: Text('Asiento'),
                                  onSort: (columnIndex, ascending) {
                                    setState(() {
                                      _sortColumnIndex = columnIndex;
                                      _sortAscending = ascending;
                                      if (ascending) {
                                        _dataRows.sort((a, b) => a
                                            .cells[0].child
                                            .toString()
                                            .compareTo(
                                                b.cells[0].child.toString()));
                                      } else {
                                        _dataRows.sort((a, b) => b
                                            .cells[0].child
                                            .toString()
                                            .compareTo(
                                                a.cells[0].child.toString()));
                                      }
                                    });
                                  },
                                ),
                                DataColumn(
                                  label: Text('Destino'),
                                ),
                              ],
                              source: MyData(_dataRows),
                            ),
                          ])),
                      // *************

                      SizedBox(
                        height: 10,
                      ),
                      // *************
                      Row(
                        children: [
                          Card(
                            elevation: 4,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            child: IntrinsicWidth(
                              child: SeatLayoutWidget(
                                onSeatStateChanged: (rowI, colI, seatState) {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: seatState == SeatState.selected
                                          ? Text("Selected Seat[$rowI][$colI]")
                                          : Text(
                                              "De-selected Seat[$rowI][$colI]"),
                                    ),
                                  );
                                  if (seatState == SeatState.selected) {
                                    selectedSeats.add(
                                        SeatNumber(rowI: rowI, colI: colI));
                                  } else {
                                    selectedSeats.remove(
                                        SeatNumber(rowI: rowI, colI: colI));
                                  }
                                },
                                stateModel: const SeatLayoutStateModel(
                                  pathDisabledSeat: StuffApp.blackSeat,
                                  pathSelectedSeat: StuffApp.redSeat,
                                  pathSoldSeat: StuffApp.blueSeat,
                                  pathUnSelectedSeat: StuffApp.whiteSeat,
                                  rows: 7,
                                  cols: 4,
                                  seatSvgSize: 60,
                                  currentSeatsState: [
                                    [
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.selected,
                                    ],
                                    [
                                      SeatState.unselected,
                                      SeatState.empty,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                    [
                                      SeatState.unselected,
                                      SeatState.empty,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                    [
                                      SeatState.unselected,
                                      SeatState.empty,
                                      SeatState.sold,
                                      SeatState.sold,
                                    ],
                                    [
                                      SeatState.unselected,
                                      SeatState.empty,
                                      SeatState.sold,
                                      SeatState.sold,
                                    ],
                                    [
                                      SeatState.empty,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                      SeatState.unselected,
                                    ],
                                    [
                                      SeatState.empty,
                                      SeatState.unselected,
                                      SeatState.disabled,
                                      SeatState.empty,
                                    ]
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Column(children: [
                                SvgPicture.asset(
                                  StuffApp.whiteSeat,
                                  width: 60,
                                ),
                                const Text(
                                  "Disponible",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                              Column(children: [
                                SvgPicture.asset(
                                  StuffApp.redSeat,
                                  width: 60,
                                ),
                                const Text(
                                  "Seleccionado",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                              Column(children: [
                                SvgPicture.asset(
                                  StuffApp.blueSeat,
                                  width: 60,
                                ),
                                const Text(
                                  "Reservado",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                              Column(children: [
                                SvgPicture.asset(
                                  StuffApp.blackSeat,
                                  width: 60,
                                ),
                                const Text(
                                  "Conductor",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ]),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextButton.icon(
                        icon: const Icon(CupertinoIcons.right_chevron),
                        label: const Text('Continuar'),
                        onPressed: () {
                          Navigator.pushNamed(context, "/pay");
                        },
                        style: TextButton.styleFrom(
                            foregroundColor: ColorsApp.whiteColor,
                            backgroundColor: ColorsApp.primayColor,
                            minimumSize: Size(
                              MediaQuery.of(context).size.width / 1.5,
                              0,
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // *************
                    ],
                  ),
                )
              ]))
        ])));
  }
}

class MyData extends DataTableSource {
  final List<DataRow> _dataRows;

  MyData(this._dataRows);

  @override
  DataRow getRow(int index) {
    if (index >= _dataRows.length) return _dataRows[_dataRows.length - 1];
    return _dataRows[index];
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _dataRows.length;

  @override
  int get selectedRowCount => 0;
}

class SeatNumber {
  final int rowI;
  final int colI;

  const SeatNumber({required this.rowI, required this.colI});

  @override
  bool operator ==(Object other) {
    return rowI == (other as SeatNumber).rowI &&
        colI == (other as SeatNumber).colI;
  }

  @override
  int get hashCode => rowI.hashCode;

  @override
  String toString() {
    return '[$rowI][$colI]';
  }
}
