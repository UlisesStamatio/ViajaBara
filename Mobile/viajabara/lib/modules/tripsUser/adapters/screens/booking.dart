import 'dart:async';
import 'dart:convert';

import 'package:book_my_seat/book_my_seat.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/stop_over/stop_over.dart';
import 'package:viajabara/domain/entities/trip/filterType.dart';
import 'package:viajabara/domain/entities/trip/seat_booking.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/domain/entities/visual_config/visual_config.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/custom_progress_indicator.dart';
import 'package:viajabara/modules/tripsUser/adapters/methods/show_modal_details_trip.dart';
import 'package:viajabara/modules/tripsUser/adapters/methods/show_modal_info.dart';
import 'package:viajabara/modules/tripsUser/adapters/widgets/BookTripsDataSource.dart';
import 'package:viajabara/providers/auth_provider.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  final _formKey = GlobalKey<FormState>();
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
  List<List<SeatState>> seatStateCleanList = [
    [
      SeatState.unselected,
      SeatState.unselected,
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
      SeatState.unselected,
      SeatState.unselected,
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
  ];
  List<String> seatsNumberDistribution = [
    "4-1",
    "7-5",
    "10-8",
    "13-11",
    "16-14",
    "19-17",
    "20"
  ];
  List<int> seatsSold = [];
  late bool thereAreUnassignedSeats;
  VisualConfigDto visualConfigDto = VisualConfigDto.empty();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<void> _initialization;
  BookTrip bookTrip = BookTrip();
  TripDto tripDto = TripDto();
  int rowsPerPagePersonalized = 0;
  late List<DataRow> _rows;
  late List<SeatBooking> seatsBooking;
  late int seatsAvailableToSelect;
  int seatIdxToAssignNumber = 0;

  void assignSeatNumber(int selectedRow, int selectedColumn) {
    int seatNumber = patternList
        .firstWhere(
          (entry) => entry.key == '[$selectedRow][$selectedColumn]',
          orElse: () => const MapEntry('', -1),
        )
        .value;
    if (seatNumber != -1) {
      setState(() {
        seatsBooking[seatIdxToAssignNumber].seatNumber = seatNumber.toString();
        seatStateCleanList[selectedRow][selectedColumn] = SeatState.selected;
        _regenerateRows();
      });
      print(seatsBooking);
    }
  }

  @override
  void initState() {
    super.initState();
    _initialization = _initializeData();
  }

  Future<void> loadSeatsSelected() async {
    if (mounted) {
      Completer<void> completer = Completer<void>();
      try {
        seatsSold =
            await AuthProvider().getSeatsDistributionOfSpecificTravel(bookTrip);

        completer.complete();
      } catch (e) {
        print('Error loadSeatsSelected: $e');
        completer.completeError(e);
      }
      return completer.future;
    }
  }

  Future<void> _initializeData() async {
    await loadVisualConfig();
    await loadBookTrip();
    await loadTripSelected();
    await loadSeatsSelected();
    if (bookTrip.seats != null && tripDto.id != null) {
      seatsBooking = await generateSeatBookings(bookTrip.seats!);
      seatsAvailableToSelect = seatsBooking.length;
      thereAreUnassignedSeats = areThereUnassignedSeats();
      _rows = _generateRows();
      updateSeatStateList();
      rebuildListView();
    }
    rowsPerPagePersonalized = calculateRowsPerPage(bookTrip.seats!);
    Future.delayed(const Duration(seconds: 3), () {
      _formKey.currentState?.validate();
    });
  }

  void updateSeatStateList() {
    for (int i = 0; i < seatStateCleanList.length; i++) {
      for (int j = 0; j < seatStateCleanList[i].length; j++) {
        int seatNumber =
            patternList[i * seatStateCleanList[i].length + j].value;

        if (seatsSold.contains(seatNumber)) {
          seatStateCleanList[i][j] = SeatState.sold;
        }
      }
    }
  }

  void cleanIndexSeatStateList(int index) {
    for (int i = 0; i < seatStateCleanList.length; i++) {
      for (int j = 0; j < seatStateCleanList[i].length; j++) {
        int seatNumber =
            patternList[i * seatStateCleanList[i].length + j].value;

        if (index == seatNumber) {
          setState(() {
            print("[$i][$j]");
            print(seatStateCleanList[i][j].toString());
            seatStateCleanList[i][j] = SeatState.unselected;
            print(seatStateCleanList[i][j].toString());
          });
        }
      }
    }
  }

  List<Widget> seatLayoutWidgets = [];
  void rebuildListView() {
    Key newKey = UniqueKey();
    setState(() {
      seatLayoutWidgets = List.generate(
        seatStateCleanList.length,
        (index) => Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10,
                  ),
                  child: SizedBox(
                    width: 50,
                    child: Text(
                      seatsNumberDistribution[index],
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SeatLayoutWidget(
                  key: newKey,
                  onSeatStateChanged: (rowI, colI, seatState) {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: seatState == SeatState.selected
                            ? Text("Selected Seat[$index][$colI]")
                            : Text("De-selected Seat[$index][$colI]"),
                      ),
                    );
                    setState(() {
                      assignSeatNumber(index, colI);
                      areThereUnassignedSeats();
                    });
                  },
                  stateModel: SeatLayoutStateModel(
                    pathDisabledSeat: StuffApp.blackSeat,
                    pathSelectedSeat: StuffApp.redSeat,
                    pathSoldSeat: StuffApp.blueSeat,
                    pathUnSelectedSeat: StuffApp.whiteSeat,
                    rows: 1,
                    cols: 4,
                    seatSvgSize: 60,
                    currentSeatsState: [seatStateCleanList[index]],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 2,
            )
          ],
        ),
      );
    });
  }

  void editSeat(int selectedRow) {
    setState(() {
      cleanIndexSeatStateList(int.parse(seatsBooking[selectedRow].seatNumber));
      seatsBooking[selectedRow].seatNumber = "S/N";
      _regenerateRows();
      rebuildListView();
    });
  }

  List<DataRow> _generateRows() {
    List<DataRow> rows = [];

    for (int index = 0; index < seatsBooking.length; index++) {
      final seatBooking = seatsBooking[index];

      rows.add(DataRow(cells: [
        DataCell(Text(seatBooking.passengerNumber.toString())),
        DataCell(Text(seatBooking.seatNumber)),
        DataCell(Row(
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                editSeat(index);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                print('Acción para el segundo elemento en la fila $index');
              },
            ),
          ],
        )),
      ]));
    }

    return rows;
  }

  void _regenerateRows() {
    setState(() {
      _rows = _generateRows();
    });
  }

  bool areThereUnassignedSeats() {
    seatIdxToAssignNumber =
        seatsBooking.indexWhere(((seat) => seat.seatNumber == "S/N"));
    setState(() {
      thereAreUnassignedSeats =
          seatsBooking.any((seat) => seat.seatNumber == "S/N");
    });
    return thereAreUnassignedSeats;
  }

  Future<List<SeatBooking>> generateSeatBookings(int numberOfBookings) async {
    Completer<List<SeatBooking>> completer = Completer<List<SeatBooking>>();

    try {
      await Future.delayed(Duration(seconds: 1));

      List<SeatBooking> seatBookings = [];

      for (int i = 1; i <= numberOfBookings; i++) {
        seatBookings.add(SeatBooking(
          seatNumber: 'S/N',
          passengerNumber: i,
        ));
      }

      completer.complete(seatBookings);
    } catch (e) {
      print('Error generating seat bookings: $e');
      completer.completeError(e);
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
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
              child: FutureBuilder(
                  future: _initialization,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
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
                                        icon: const Icon(
                                            Icons.remove_red_eye_outlined),
                                        label: const Text('Detalles'),
                                        onPressed: () {
                                          _showModalInfo(context, tripDto);
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                ColorsApp.whiteColor,
                                            backgroundColor:
                                                ColorsApp.primayColor,
                                            minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              0,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      // *Aqui esta mi paginated, despliega la lista
                                      PaginatedDataTable(
                                        columns: const [
                                          DataColumn(
                                            label: Text('Pasajero'),
                                          ),
                                          DataColumn(label: Text('Asiento')),
                                          DataColumn(label: Text('Acción')),
                                        ],
                                        source: BookTripsDataSource(
                                            bookTrip, _rows),
                                        rowsPerPage: rowsPerPagePersonalized,
                                      ),
                                    ])),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: thereAreUnassignedSeats
                                      ? Row(
                                          children: [
                                            Card(
                                              elevation: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: SizedBox(
                                                  width: 285,
                                                  height: 430,
                                                  child: ListView(
                                                      children: List.generate(
                                                          seatStateCleanList
                                                              .length,
                                                          (index) => Column(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      // Padding(
                                                                      //   padding: const EdgeInsets
                                                                      //       .symmetric(
                                                                      //       vertical:
                                                                      //           8.0,
                                                                      //       horizontal:
                                                                      //           10),
                                                                      //   child:
                                                                      //       SizedBox(
                                                                      //     width:
                                                                      //         50, // Ancho máximo basado en el diseño original
                                                                      //     child:
                                                                      //         Text(
                                                                      //       seatsNumberDistribution[index],
                                                                      //       style:
                                                                      //           const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                                                      //     ),
                                                                      //   ),
                                                                      // ),
                                                                      seatLayoutWidgets[
                                                                          index],
                                                                      // SeatLayoutWidget(
                                                                      //   onSeatStateChanged: (rowI,
                                                                      //       colI,
                                                                      //       seatState) {
                                                                      //     ScaffoldMessenger.of(context)
                                                                      //         .hideCurrentSnackBar();
                                                                      //     ScaffoldMessenger.of(context)
                                                                      //         .showSnackBar(
                                                                      //       SnackBar(
                                                                      //         content: seatState == SeatState.selected ? Text("Selected Seat[$index][$colI]") : Text("De-selected Seat[$index][$colI]"),
                                                                      //       ),
                                                                      //     );
                                                                      //     assignSeatNumber(
                                                                      //         index,
                                                                      //         colI);
                                                                      //     areThereUnassignedSeats();
                                                                      //   },
                                                                      //   stateModel:
                                                                      //       SeatLayoutStateModel(
                                                                      //     pathDisabledSeat:
                                                                      //         StuffApp.blackSeat,
                                                                      //     pathSelectedSeat:
                                                                      //         StuffApp.redSeat,
                                                                      //     pathSoldSeat:
                                                                      //         StuffApp.blueSeat,
                                                                      //     pathUnSelectedSeat:
                                                                      //         StuffApp.whiteSeat,
                                                                      //     rows:
                                                                      //         1,
                                                                      //     cols:
                                                                      //         4,
                                                                      //     seatSvgSize:
                                                                      //         60,
                                                                      //     currentSeatsState: [
                                                                      //       seatStateCleanList[index],
                                                                      //     ],
                                                                      //   ),
                                                                      // ),
                                                                    ],
                                                                  ),
                                                                  const Divider(
                                                                    height: 2,
                                                                  )
                                                                ],
                                                              )))),
                                            ),
                                            Column(
                                              children: [
                                                Column(children: [
                                                  SvgPicture.asset(
                                                    StuffApp.whiteSeat,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Disponible",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                                Column(children: [
                                                  SvgPicture.asset(
                                                    StuffApp.redSeat,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Seleccionado",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                                Column(children: [
                                                  SvgPicture.asset(
                                                    StuffApp.blueSeat,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Vendido",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                                Column(children: [
                                                  SvgPicture.asset(
                                                    StuffApp.blackSeat,
                                                    width: 50,
                                                  ),
                                                  const Text(
                                                    "Conductor",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ]),
                                              ],
                                            ),
                                          ],
                                        )
                                      : TextButton.icon(
                                          icon: const Icon(
                                              CupertinoIcons.right_chevron),
                                          label: const Text('Continuar'),
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, "/pay");
                                          },
                                          style: TextButton.styleFrom(
                                              foregroundColor:
                                                  ColorsApp.whiteColor,
                                              backgroundColor:
                                                  ColorsApp.primayColor,
                                              minimumSize: Size(
                                                MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    1.5,
                                                0,
                                              )),
                                        ),
                                ),
                              ],
                            )
                          ]);
                    } else {
                      return CustomCircularProgressIndicator();
                    }
                  }))
        ])));
  }

  Future<void> loadVisualConfig() async {
    Completer<void> completer = Completer<void>();

    try {
      SharedPreferences prefs = await _prefs;
      if (prefs.containsKey("visualConfig")) {
        Map<String, dynamic> jsonMap =
            jsonDecode(prefs.getString("visualConfig")!);
        visualConfigDto = VisualConfigDto.fromJson(jsonMap);
      } else {
        visualConfigDto = VisualConfigDto.empty();
        prefs.setString("visualConfig", jsonEncode(visualConfigDto));
      }
      completer.complete();
    } catch (e) {
      print('Error loadVisualConfig: $e');
      completer.completeError(e);
    }

    return completer.future;
  }

  Future<void> loadBookTrip() async {
    Completer<void> completer = Completer<void>();
    try {
      SharedPreferences prefs = await _prefs;
      if (prefs.containsKey("bookTrip")) {
        Map<String, dynamic> jsonMap = jsonDecode(prefs.getString("bookTrip")!);
        bookTrip = BookTrip.fromJson(jsonMap);
      } else {
        bookTrip = BookTrip();
        prefs.setString("bookTrip", jsonEncode(bookTrip.toJson()));
      }
      completer.complete();
    } catch (e) {
      print('Error loadBookTrip: $e');
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<void> loadTripSelected() async {
    Completer<void> completer = Completer<void>();
    try {
      SharedPreferences prefs = await _prefs;
      if (prefs.containsKey("tripSelected")) {
        Map<String, dynamic> jsonMap =
            jsonDecode(prefs.getString("tripSelected")!);
        tripDto = TripDto.fromJson(jsonMap);
        print("************************");
        print(tripDto.listStopovers);
      }
      completer.complete();
    } catch (e) {
      print('Error loadTripSelected: $e');
      completer.completeError(e);
    }

    return completer.future;
  }

  void _showModalInfo(BuildContext context, TripDto tripDto) {
    showModalInfo(context, tripDto);
  }

  int calculateRowsPerPage(int totalSeats) {
    if (totalSeats >= 4) {
      // Si hay al menos 4 resultados, permitir 4 filas por página
      return 4;
    } else if (totalSeats >= 2) {
      // Si hay al menos 2 resultados, permitir 2 filas por página
      return 2;
    } else {
      // Si hay menos de 2 resultados, permitir solo 1 fila por página
      return 1;
    }
  }

  double calculateRoutePrice(
      TripDto trip, VisualConfigDto visualConfigDto, BookTrip bookTrip) {
    if (trip.filterType?.value == "Parada" && trip.listStopovers != null) {
      double routeMeters = trip.meters ?? 0.0;
      for (StopOverDto stopOver in trip.listStopovers!) {
        if (stopOver.meters != null &&
            stopOver.address!.id == bookTrip.originId) {
          routeMeters -= stopOver.meters!;
        }
      }
      double routePrice =
          (routeMeters * 0.001) * visualConfigDto.kilometerPrice!;
      return double.parse(routePrice.toStringAsFixed(2));
    } else {
      double routeMeters = trip.meters ?? 0.0;
      double routePrice =
          (routeMeters * 0.001) * visualConfigDto.kilometerPrice!;
      return double.parse(routePrice.toStringAsFixed(2));
    }
  }
}
