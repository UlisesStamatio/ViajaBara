import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/address.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/state/state_list.dart';
import 'package:viajabara/domain/entities/trip/filterType.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/domain/entities/visual_config/visual_config.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/custom_progress_indicator.dart';
import 'package:viajabara/modules/tripsUser/adapters/entities/duty.dart';
import 'package:viajabara/providers/auth_provider.dart';

class Trip extends StatefulWidget {
  const Trip({super.key});

  @override
  State<Trip> createState() => _TripState();
}

class _TripState extends State<Trip> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  TextEditingController originController = TextEditingController();
  TextEditingController destinyController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController seatController = TextEditingController();
  late Future<void> _initialization;
  Future<void> _search = Future.value();
  BookTrip bookTrip = BookTrip();
  List<DutyItem> duties = [];
  List<StateList> states = [];
  List<TripDto> trips = [];
  List<StateList> filteredStates = [];
  List<StateList> filteredStatesDestiny = [];
  List<StateList> filteredStatesDestinyRes = [];
  DateTime fecha = DateTime.now();
  VisualConfigDto visualConfigDto = VisualConfigDto.empty();
  bool searched = false;

  Future<void> _initializeSearch() async {
    await loadTripsByFiltersClient();
  }

  Future<void> loadTripsByFiltersClient() async {
    if (mounted) {
      Completer<void> completer = Completer<void>();
      try {
        trips = await AuthProvider().getTripsByFiltersClient(bookTrip);
        completer.complete();
      } catch (e) {
        print('Error loadTripsByFiltersClient: $e');
        completer.completeError(e);
      }
      return completer.future;
    }
  }

  void initializeSearch() {
    if (mounted) {
      setState(() {
        _search = _initializeSearch();
        searched = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initialization = _initializeData();
  }

  Future<void> _initializeData() async {
    await loadVisualConfig();
    await loadBookTrip();
    // await loadDuties();
    dateController.text = "${DateTime.now().toLocal()}".split(' ')[0];
    bookTrip.date = dateController.text;
    await loadStatesForTrip();
    Future.delayed(const Duration(seconds: 3), () {
      _formKey.currentState?.validate();
    });
  }

  Future<void> loadVisualConfig() async {
    Completer<void> completer = Completer<void>();

    try {
      SharedPreferences prefs = await _prefs;
      if (prefs.containsKey("visualConfig")) {
        Map<String, dynamic> jsonMap =
            jsonDecode(prefs.getString("visualConfig")!);
        visualConfigDto = VisualConfigDto.fromJson(jsonMap);
        print("visualConfigDto ");
        print(visualConfigDto);
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

  // Future<void> loadDuties() async {
  //   Completer<void> completer = Completer<void>();
  //   try {
  //     List<DutyItem> dutyList = await AuthProvider().getDutiesEnabled();
  //     setState(() {
  //       duties = dutyList;
  //       dutyController.text = dutyList[0].name;
  //       bookTrip.dutyid = dutyList[0].id;
  //     });
  //     completer.complete();
  //   } catch (e) {
  //     print('Error loadDuties: $e');
  //     completer.completeError(e);
  //   }
  //   return completer.future;
  // }

  Future<void> loadStatesForTrip() async {
    Completer<void> completer = Completer<void>();
    try {
      List<StateList> statesList =
          await AuthProvider().getStatesForTrip(dateController.text);
      if (mounted) {
        setState(() {
          states = statesList;
          if (statesList.isNotEmpty) {
            originController.text = statesList[0].addresses[0].description;
            bookTrip.stateOriginId = statesList[0].id;
            bookTrip.originId = statesList[0].addresses[0].id;
          }
          filteredStates = statesList;
          if (filteredStates.isNotEmpty) {
            filterStatesDestiny(filteredStates[0].id,
                filteredStates[0].addresses[0].id, setState);
          }
          print("filteredStates.isEmpty ");
          print(filteredStates.isEmpty);
        });
      }

      completer.complete();
    } catch (e) {
      print('Error loadStatesForTrip: $e');
      completer.completeError(e);
    }
    return completer.future;
  }

// Methods
  Future<void> _selectDate(BuildContext context) async {
    List<String> datePath = dateController.text.split("-");
    fecha = DateTime(
      int.parse(datePath[0]),
      int.parse(datePath[1]),
      int.parse(datePath[2]),
    );
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsApp.primayColor,
              onPrimary: ColorsApp.whiteColor,
              onSurface: ColorsApp.text,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != fecha) {
      if (mounted) {
        setState(() {
          dateController.text = "${picked.toLocal()}".split(' ')[0];
          bookTrip.date = dateController.text;
          cleanInputs();
          loadStatesForTrip();
        });
      }
    }
  }

  void filterStates(String query, StateSetter setter) {
    print("filterStates $query");
    setter(() {
      if (query == '') {
        filteredStates = List<StateList>.from(states);
      } else {
        filteredStates = states
            .map((state) {
              bool stateNameMatches =
                  state.name.toLowerCase().contains(query.toLowerCase());
              if (stateNameMatches) {
                return state;
              }
              if (!stateNameMatches) {
                List<Address> matchingAddresses = state.addresses
                    .where((address) => address.description
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
                if (matchingAddresses.isNotEmpty) {
                  return StateList(
                    id: state.id,
                    name: state.name,
                    addresses: matchingAddresses,
                  );
                }
              }

              return null;
            })
            .whereType<StateList>()
            .toList();
      }
    });
  }

  void filterStatesDestinySelect(String query, StateSetter setter) {
    print("filteredStatesDestiny $query");
    setter(() {
      if (query == '') {
        filteredStatesDestiny = List<StateList>.from(filteredStatesDestinyRes);
      } else {
        filteredStatesDestiny = filteredStatesDestinyRes
            .map((state) {
              bool stateNameMatches =
                  state.name.toLowerCase().contains(query.toLowerCase());
              if (stateNameMatches) {
                return state;
              }
              if (!stateNameMatches) {
                List<Address> matchingAddresses = state.addresses
                    .where((address) => address.description
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                    .toList();
                if (matchingAddresses.isNotEmpty) {
                  return StateList(
                    id: state.id,
                    name: state.name,
                    addresses: matchingAddresses,
                  );
                }
              }

              return null;
            })
            .whereType<StateList>()
            .toList();
      }
    });
  }

  void filterStatesDestiny(int stateId, int addressId, StateSetter setter) {
    print("filterStatesDestiny $stateId $addressId");
    setter(() {
      bookTrip.stateOriginId = stateId;
      bookTrip.originId = addressId;
      filteredStatesDestiny = filteredStates
          .map((state) {
            bool stateIdMatches = state.id == stateId;

            if (stateIdMatches) {
              List<Address> otherAddresses = state.addresses
                  .where((address) => address.id != addressId)
                  .toList();

              if (otherAddresses.isNotEmpty) {
                return StateList(
                  id: state.id,
                  name: state.name,
                  addresses: otherAddresses,
                );
              }
            }
            return null;
          })
          .whereType<StateList>()
          .toList();
    });
    filteredStatesDestinyRes = filteredStatesDestiny;
  }

  void reloadStates() {
    if (mounted) {
      setState(() {
        filteredStates = List.from(states);
      });
    }
  }

  void cleanInputs() {
    originController.text = "";
    destinyController.text = "";
    seatController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            _formKey.currentState?.validate();
            return Scaffold(
              appBar: AppBar(
                title: Container(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Viajar',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                elevation: 4,
              ),
              body: SafeArea(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    SvgPicture.asset(
                      StuffApp.bgGeneral,
                      fit: BoxFit.cover,
                    ),
                    SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: ColorsApp.whiteColor,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Form(
                              key: _formKey,
                              onChanged: () {
                                if (mounted) {
                                  setState(() {
                                    _isButtonDisabled =
                                        !_formKey.currentState!.validate();
                                  });
                                }
                              },
                              child: Column(
                                children: <Widget>[
                                  Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: Column(
                                        children: [
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 160,
                                                  child: TextFormField(
                                                    controller: dateController,
                                                    onTap: () {
                                                      _selectDate(context);
                                                    },
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Campo obligatorio';
                                                      }
                                                      return null;
                                                    },
                                                    cursorColor:
                                                        ColorsApp.primayColor,
                                                    style: const TextStyle(
                                                      color: ColorsApp.text,
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Ida*',
                                                      filled: true,
                                                      fillColor:
                                                          ColorsApp.whiteColor,
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: ColorsApp.text,
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: ColorsApp.text,
                                                      ),
                                                      errorMaxLines: 2,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .dangerColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                      ColorsApp
                                                                          .text,
                                                                  width: 1.0,
                                                                  style: BorderStyle
                                                                      .solid)),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 160,
                                                ),
                                              ]),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 160,
                                                  child: TextFormField(
                                                    controller:
                                                        originController,
                                                    onTap: () {
                                                      _showModalSelectAddress(
                                                          context);
                                                    },
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (states.isEmpty) {
                                                        return 'Elige otra fecha';
                                                      } else if (value ==
                                                              null ||
                                                          value.isEmpty) {
                                                        return 'Campo obligatorio';
                                                      }
                                                      return null;
                                                    },
                                                    cursorColor:
                                                        ColorsApp.primayColor,
                                                    style: const TextStyle(
                                                      color: ColorsApp.text,
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Origen*',
                                                      filled: true,
                                                      fillColor:
                                                          ColorsApp.whiteColor,
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: ColorsApp.text,
                                                      ),
                                                      labelStyle:
                                                          const TextStyle(
                                                        color: ColorsApp.text,
                                                      ),
                                                      errorMaxLines: 2,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .dangerColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                      ColorsApp
                                                                          .text,
                                                                  width: 1.0,
                                                                  style: BorderStyle
                                                                      .solid)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                  child: TextFormField(
                                                    enabled: originController
                                                        .text.isNotEmpty,
                                                    controller:
                                                        destinyController,
                                                    onTap: () {
                                                      _showModalSelectAddressDestiny(
                                                          context);
                                                    },
                                                    readOnly: true,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (originController.text
                                                              .isNotEmpty &&
                                                          value == "") {
                                                        return 'Campo obligatorio';
                                                      }
                                                      return null;
                                                    },
                                                    cursorColor:
                                                        ColorsApp.primayColor,
                                                    style: TextStyle(
                                                      color: originController
                                                              .text.isEmpty
                                                          ? ColorsApp.whiteColor
                                                          : ColorsApp.text,
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Destino*',
                                                      filled: true,
                                                      fillColor:
                                                          originController
                                                                  .text.isEmpty
                                                              ? ColorsApp.text
                                                              : ColorsApp
                                                                  .whiteColor,
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: ColorsApp.text,
                                                      ),
                                                      labelStyle: TextStyle(
                                                        color: originController
                                                                .text.isEmpty
                                                            ? ColorsApp
                                                                .whiteColor
                                                            : ColorsApp.text,
                                                      ),
                                                      errorMaxLines: 2,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .dangerColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                      ColorsApp
                                                                          .text,
                                                                  width: 1.0,
                                                                  style: BorderStyle
                                                                      .solid)),
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 160,
                                                  child: TextFormField(
                                                    controller: seatController,
                                                    onChanged: (value) {
                                                      if (mounted) {
                                                        setState(() {
                                                          if (value != null &&
                                                              value != "") {
                                                            bookTrip.seats =
                                                                int.parse(
                                                                    value);
                                                          }
                                                        });
                                                      }
                                                    },
                                                    keyboardType:
                                                        TextInputType.number,
                                                    inputFormatters: <TextInputFormatter>[
                                                      FilteringTextInputFormatter
                                                          .digitsOnly,
                                                      FilteringTextInputFormatter
                                                          .allow(
                                                        RegExp(r'^[1-9]\d*'),
                                                      ),
                                                    ],
                                                    validator: (value) {
                                                      if (destinyController
                                                          .text.isNotEmpty) {
                                                        if ((value == null ||
                                                            value.isEmpty)) {
                                                          return 'Campo obligatorio';
                                                        }
                                                        if (int.parse(value) <
                                                                0 ||
                                                            int.parse(value) >
                                                                20) {
                                                          print(
                                                              "Asientos ${int.parse(value)}");
                                                          return 'Coloca un valor entre 1-20';
                                                        }
                                                        return null;
                                                      }
                                                    },
                                                    cursorColor:
                                                        ColorsApp.primayColor,
                                                    style: const TextStyle(
                                                      color: ColorsApp.text,
                                                    ),
                                                    decoration: InputDecoration(
                                                      enabled: destinyController
                                                          .text.isNotEmpty,
                                                      labelText: 'Asientos*',
                                                      filled: true,
                                                      fillColor:
                                                          destinyController
                                                                  .text.isEmpty
                                                              ? ColorsApp.text
                                                              : ColorsApp
                                                                  .whiteColor,
                                                      hintStyle: TextStyle(
                                                        color: destinyController
                                                                .text.isEmpty
                                                            ? ColorsApp
                                                                .whiteColor
                                                            : ColorsApp.text,
                                                      ),
                                                      labelStyle: TextStyle(
                                                        color: destinyController
                                                                .text.isEmpty
                                                            ? ColorsApp
                                                                .whiteColor
                                                            : ColorsApp.text,
                                                      ),
                                                      errorMaxLines: 2,
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .primayColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      errorBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      4.0),
                                                          borderSide: const BorderSide(
                                                              color: ColorsApp
                                                                  .dangerColor,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          4.0),
                                                              borderSide: const BorderSide(
                                                                  color:
                                                                      ColorsApp
                                                                          .text,
                                                                  width: 1.0,
                                                                  style: BorderStyle
                                                                      .solid)),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 160,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (!_isButtonDisabled) {
                                                        initializeSearch();
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(
                                                        _isButtonDisabled
                                                            ? ColorsApp.muted
                                                            : ColorsApp
                                                                .primayColor,
                                                      ),
                                                    ),
                                                    child: const Row(children: [
                                                      Icon(
                                                        Icons.search,
                                                        size: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        'Buscar',
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      )
                                                    ]),
                                                  ),
                                                ),
                                              ])
                                        ],
                                      )),
                                ],
                              ),
                            ),
                          ),
                          FutureBuilder(
                              future: _search,
                              builder: (context, snapshot2) {
                                if (snapshot2.connectionState ==
                                    ConnectionState.done) {
                                  return !searched && trips.isEmpty
                                      ? Card(
                                          elevation: 5,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0,
                                                horizontal: 40.0),
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                    StuffApp.waitingData,
                                                    height: 100),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                const Text(
                                                    "Llena los campos y empieza a viajar",
                                                    style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: "Tahoma"))
                                              ],
                                            ),
                                          ),
                                        )
                                      : searched && trips.isEmpty
                                          ? Card(
                                              elevation: 5,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0,
                                                        horizontal: 40.0),
                                                child: Column(
                                                  children: [
                                                    SvgPicture.asset(
                                                        StuffApp.dataNotFound,
                                                        height: 100),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    const Text(
                                                        "No hay viajes disponibles con los datos ingresados",
                                                        style: TextStyle(
                                                            fontSize: 13.0,
                                                            fontFamily:
                                                                "Tahoma"))
                                                  ],
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 360,
                                              child: ListView.builder(
                                                  itemCount: trips.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Stack(children: [
                                                      Card(
                                                        elevation: 5,
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 20.0,
                                                            horizontal: 16.0),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: <Widget>[
                                                              Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: <Widget>[
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: <Widget>[
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.only(
                                                                            right:
                                                                                26.0,
                                                                          ),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: [
                                                                              ImageFromBase64(base64String: trips[index].driver!.profile!),
                                                                              Column(
                                                                                children: [
                                                                                  Text(
                                                                                    '${formatTime(trips[index].startTime!)} hrs',
                                                                                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  const Text(
                                                                                    'Salida',
                                                                                    style: TextStyle(
                                                                                      fontSize: 14.0,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              const Icon(CupertinoIcons.arrow_right, size: 20),
                                                                              Column(
                                                                                children: [
                                                                                  Text(
                                                                                    '${formatTime(trips[index].endTime!)} hrs',
                                                                                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  const Text(
                                                                                    'Llegada estimada',
                                                                                    style: TextStyle(
                                                                                      fontSize: 14.0,
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                12.0),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children: [
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.airline_seat_recline_extra, // Puedes cambiar este icono según tus necesidades
                                                                                      color: ColorsApp.text,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 4.0),
                                                                                      child: Text(
                                                                                        '${trips[index].enabledSeats} disponible(s)',
                                                                                        style: const TextStyle(
                                                                                          fontSize: 14.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: ColorsApp.text,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.timeline, // Puedes cambiar este icono según tus necesidades
                                                                                      color: ColorsApp.text,
                                                                                    ),
                                                                                    Padding(
                                                                                      padding: const EdgeInsets.only(left: 4.0),
                                                                                      child: Text(
                                                                                        '${trips[index].route!.stopOvers!.length} escala(s)',
                                                                                        style: const TextStyle(
                                                                                          fontSize: 14.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                          color: ColorsApp.text,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              '\$ ${((trips[index].route!.meters! * 0.001) * visualConfigDto.kilometerPrice!).toStringAsFixed(2)} MXN',
                                                                              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: ColorsApp.successColor),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        top:
                                                                            15.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  children: <Widget>[
                                                                    TextButton
                                                                        .icon(
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .remove_red_eye_outlined),
                                                                      label: const Text(
                                                                          'Detalles'),
                                                                      onPressed:
                                                                          () {
                                                                        _showModalInfo(
                                                                            context,
                                                                            trips[index]);
                                                                      },
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            ColorsApp.whiteColor,
                                                                        backgroundColor:
                                                                            ColorsApp.primayColor,
                                                                      ),
                                                                    ),
                                                                    TextButton
                                                                        .icon(
                                                                      icon: const Icon(
                                                                          CupertinoIcons
                                                                              .cart_fill),
                                                                      label: const Text(
                                                                          'Reservar'),
                                                                      onPressed:
                                                                          () {
                                                                        // saveBookTripOnSharedPreferences();
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            '/booking');
                                                                      },
                                                                      style: TextButton
                                                                          .styleFrom(
                                                                        foregroundColor:
                                                                            ColorsApp.whiteColor,
                                                                        backgroundColor:
                                                                            ColorsApp.primayColor,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top:
                                                            0.0, // Ajusta según sea necesario
                                                        right:
                                                            5.0, // Ajusta según sea necesario
                                                        child: Chip(
                                                          avatar: Icon(
                                                              CupertinoIcons
                                                                  .bus,
                                                              color: trips[index]
                                                                          .filterType!
                                                                          .value ==
                                                                      "Parada"
                                                                  ? ColorsApp
                                                                      .secondaryColor
                                                                  : ColorsApp
                                                                      .whiteColor),
                                                          label: Text(
                                                            trips[index]
                                                                .filterType!
                                                                .value,
                                                            style: TextStyle(
                                                                color: trips[index]
                                                                            .filterType!
                                                                            .value ==
                                                                        "Parada"
                                                                    ? ColorsApp
                                                                        .secondaryColor
                                                                    : ColorsApp
                                                                        .whiteColor),
                                                          ),
                                                          backgroundColor:
                                                              ColorsApp.text,
                                                          elevation: 5,
                                                        ),
                                                      ),
                                                    ]);
                                                  }),
                                            );
                                } else {
                                  return CustomCircularProgressIndicator();
                                }
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return CustomCircularProgressIndicator();
          }
        });
  }

  void _showModalSelectAddress(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "Origen ${originController.text}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.primayColor),
                      ),
                    ),
                  ),
                  const Divider(
                    color: ColorsApp.muted,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (query) {
                        filterStates(query, setState);
                      },
                      decoration: InputDecoration(
                        labelText: 'Filtrar',
                        filled: true,
                        fillColor: ColorsApp.whiteColor,
                        hintStyle: const TextStyle(
                          color: ColorsApp.text,
                        ),
                        labelStyle: const TextStyle(
                          color: ColorsApp.text,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: ColorsApp.primayColor,
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.primayColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.primayColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.dangerColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.dangerColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: filteredStates.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          iconColor: ColorsApp.secondaryColor,
                          textColor: ColorsApp.secondaryColor,
                          collapsedBackgroundColor: ColorsApp.muted,
                          title: Text(filteredStates[index].name),
                          children:
                              filteredStates[index].addresses.map((address) {
                            return ListTile(
                              title: Text(address.description),
                              onTap: () {
                                filterStatesDestiny(filteredStates[index].id,
                                    address.id, setState);
                                originController.text = address.description;
                                destinyController.text = "";
                                print('Selected Address: ${address.id}');
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      reloadStates();
    });
  }

  void _showModalSelectAddressDestiny(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                      child: Text(
                        "Destino ${destinyController.text}",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.primayColor),
                      ),
                    ),
                  ),
                  const Divider(
                    color: ColorsApp.muted,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (query) {
                        filterStatesDestinySelect(query, setState);
                      },
                      decoration: InputDecoration(
                        labelText: 'Filtrar',
                        filled: true,
                        fillColor: ColorsApp.whiteColor,
                        hintStyle: const TextStyle(
                          color: ColorsApp.text,
                        ),
                        labelStyle: const TextStyle(
                          color: ColorsApp.text,
                        ),
                        prefixIcon: const Icon(Icons.search),
                        prefixIconColor: ColorsApp.primayColor,
                        enabledBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.primayColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.primayColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.dangerColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(4.0),
                            borderSide: const BorderSide(
                                color: ColorsApp.dangerColor,
                                width: 1.0,
                                style: BorderStyle.solid)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                      itemCount: filteredStatesDestiny.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          iconColor: ColorsApp.secondaryColor,
                          textColor: ColorsApp.secondaryColor,
                          collapsedBackgroundColor: ColorsApp.muted,
                          title: Text(filteredStatesDestiny[index].name),
                          children: filteredStatesDestiny[index]
                              .addresses
                              .map((address) {
                            return ListTile(
                              title: Text(address.description),
                              onTap: () {
                                setState(
                                  () {
                                    destinyController.text =
                                        address.description;
                                    bookTrip.stateDestinyId =
                                        filteredStatesDestiny[index].id;
                                    bookTrip.destinyId = address.id;
                                  },
                                );

                                print('Selected Address: ${address.id}');
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((value) {
      reloadStates();
    });
  }

  void _showModalInfo(BuildContext context, TripDto tripDto) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        'Detalles',
                        style: TextStyle(
                          color: ColorsApp.primayColor,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Divider(color: ColorsApp.text),
                    Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: ColorsApp.text,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Origen: ${tripDto.route!.startAddress!.state!.name}, ${tripDto.route!.startAddress!.description}',
                                style: const TextStyle(
                                  color: ColorsApp.text,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(
                                Icons.flight_land,
                                color: ColorsApp.text,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Destino: ${tripDto.route!.endAddress!.state!.name}, ${tripDto.route!.endAddress!.description}',
                                style: const TextStyle(
                                  color: ColorsApp.text,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(
                                Icons.date_range,
                                color: ColorsApp.text,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Hora: ${formatTime(tripDto.startTime!)} hrs - ${formatTime(tripDto.endTime!)} hrs',
                                style: const TextStyle(
                                  color: ColorsApp.text,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              const Icon(
                                Icons.timeline,
                                color: ColorsApp.text,
                                size: 35,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                'Escala(s): ${tripDto.route!.stopOvers!.length}',
                                style: const TextStyle(
                                  color: ColorsApp.text,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                              height: tripDto.route!.stopOvers!.length * 25,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ListView.builder(
                                    itemCount: tripDto.route!.stopOvers!.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Stack(children: [
                                            const Icon(
                                                CupertinoIcons.circle_fill),
                                            Positioned(
                                                top: 5,
                                                right: 8,
                                                child: Text(
                                                  tripDto
                                                      .route!
                                                      .stopOvers![index]
                                                      .sequence
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color:
                                                          ColorsApp.whiteColor),
                                                )),
                                          ]),
                                          Text(
                                            '${tripDto.route!.stopOvers![index].description}',
                                            style: const TextStyle(
                                              color: ColorsApp.text,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              )),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(
                                Icons.timer,
                                color: ColorsApp.text,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Tiempo estimado: 4:20 hrs.',
                                style: TextStyle(
                                  color: ColorsApp.text,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: ColorsApp.text,
                                size: 35,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Número de pasajeros: 22',
                                style: TextStyle(
                                  color: ColorsApp.text,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ])),
            ],
          ),
        );
      },
    );
  }
}

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

class ImageFromBase64 extends StatelessWidget {
  final String base64String;

  const ImageFromBase64({super.key, required this.base64String});

  @override
  Widget build(BuildContext context) {
    if (base64String != null && base64String != "") {
      Uint8List bytes = base64.decode(base64String);
      return CircleAvatar(
        radius: 30,
        backgroundImage: MemoryImage(bytes, scale: 0.1),
      );
    } else {
      return const CircleAvatar(
        radius: 30,
        backgroundColor: ColorsApp.secondaryColor,
      );
    }
  }
}
