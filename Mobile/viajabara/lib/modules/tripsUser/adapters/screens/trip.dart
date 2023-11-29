import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/address.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/state/state_list.dart';
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

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _TripState extends State<Trip> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
  List<StateList> filteredStates = [];
  List<StateList> filteredStatesDestiny = [];
  DateTime fecha = DateTime.now();

  Future<void> _initializeSearch() async {
    // await loadTripsByFiltersClient();
  }

  void initializeSearch() {
    if (mounted) {
      setState(() {
        _search = _initializeSearch();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _initialization = _initializeData();
  }

  Future<void> _initializeData() async {
    await loadBookTrip();
    // await loadDuties();
    dateController.text = "${DateTime.now().toLocal()}".split(' ')[0];
    bookTrip.date = dateController.text;
    await loadStatesForTrip();
    Future.delayed(const Duration(seconds: 3), () {
      _formKey.currentState?.validate();
    });
    await 
  }

  Future<void> loadBookTrip() async {
    if (mounted) {
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
      // List<StateList> statesList =
      //     await AuthProvider().getStatesForTrip(dateController.text);
      // setState(() {
      //   states = statesList;
      //   if (statesList.isNotEmpty) {
      //     originController.text = statesList[0].addresses[0].description;
      //     bookTrip.stateOriginId = statesList[0].id;
      //     bookTrip.originId = statesList[0].addresses[0].id;
      //   }
      //   filteredStates = statesList;
      //   if (filteredStates.isNotEmpty) {
      //     filterStatesDestiny(filteredStates[0].id,
      //         filteredStates[0].addresses[0].id, setState);
      //   }
      //   print("filteredStates.isEmpty ");
      //   print(filteredStates.isEmpty);
      // });
      // completer.complete();
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

  void filterStates(String query, StateSetter setter,
      List<StateList> statesToFilter, bool isOrigin) {
    print("filterStates $query");
    setter(() {
      if (isOrigin) {
        if (query == '') {
          statesToFilter = List<StateList>.from(states);
        } else {
          statesToFilter = states
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
      } else {}
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
                                                    controller: seatController,
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
                                              ]),
                                          SizedBox(
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
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Campo obligatorio';
                                                      } else if (int.parse(
                                                                  value) <
                                                              0 ||
                                                          int.parse(value) >
                                                              20) {
                                                        print(
                                                            "Asientos ${int.parse(value)}");
                                                        return 'Coloca un valor entre 1-20';
                                                      }
                                                      return null;
                                                    },
                                                    cursorColor:
                                                        ColorsApp.primayColor,
                                                    style: const TextStyle(
                                                      color: ColorsApp.text,
                                                    ),
                                                    decoration: InputDecoration(
                                                      labelText: 'Asientos*',
                                                      hintText: "1",
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
                                  return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 16.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              CircleAvatar(
                                                radius: 45,
                                                backgroundImage: AssetImage(
                                                    'assets/images/perfilGirl.avif'),
                                              ),
                                              SizedBox(width: 20.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      'Salida: Lugar HH:MM',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Text(
                                                      'Llegada: Lugar HH:MM',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                    SizedBox(height: 10.0),
                                                    Text(
                                                      'Pagado: \$100.0',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                TextButton.icon(
                                                  icon: const Icon(Icons
                                                      .remove_red_eye_outlined),
                                                  label: const Text('Detalles'),
                                                  onPressed: () {
                                                    _showModalSelectAddress(
                                                        context);
                                                  },
                                                  style: TextButton.styleFrom(
                                                    foregroundColor:
                                                        ColorsApp.whiteColor,
                                                    backgroundColor:
                                                        ColorsApp.primayColor,
                                                  ),
                                                ),
                                                TextButton.icon(
                                                  icon: const Icon(
                                                      CupertinoIcons.cart_fill),
                                                  label: const Text('Reservar'),
                                                  onPressed: () {
                                                    // saveBookTripOnSharedPreferences();
                                                    Navigator.pushNamed(
                                                        context, '/booking');
                                                  },
                                                  style: TextButton.styleFrom(
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
                        filterStates(query, setState, states, true);
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
                      itemCount: states.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          iconColor: ColorsApp.secondaryColor,
                          textColor: ColorsApp.secondaryColor,
                          collapsedBackgroundColor: ColorsApp.muted,
                          title: Text(states[index].name),
                          children: states[index].addresses.map((address) {
                            return ListTile(
                              title: Text(address.description),
                              onTap: () {
                                filterStatesDestiny(
                                    states[index].id, address.id, setState);
                                originController.text = address.description;

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

  void _showModalSelectAddressDestiny(
      BuildContext context, List<StateList> states) {
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
                        filterStates(query, setState, states, false);
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
                      itemCount: states.length,
                      itemBuilder: (context, index) {
                        return ExpansionTile(
                          iconColor: ColorsApp.secondaryColor,
                          textColor: ColorsApp.secondaryColor,
                          collapsedBackgroundColor: ColorsApp.muted,
                          title: Text(states[index].name),
                          children: states[index].addresses.map((address) {
                            return ListTile(
                              title: Text(address.description),
                              onTap: () {
                                setState(
                                  () {
                                    destinyController.text =
                                        address.description;
                                    bookTrip.stateDestinyId = states[index].id;
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
}
