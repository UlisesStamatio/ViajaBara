import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/details/details_travels.dart';
import 'package:viajabara/modules/tripsUser/adapters/entities/list_drivers.dart';
import 'package:viajabara/providers/auth_provider.dart';

class Trip extends StatefulWidget {
  const Trip({super.key});

  @override
  State<Trip> createState() => _TripState();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class _TripState extends State<Trip> {
  String dropdownValue = list.first;
  final _formKey = GlobalKey<FormState>();
  DateTime fecha = DateTime.now();
  TextEditingController dateController = TextEditingController();
  bool _isButtonDisabled = true;

  List<StateItem> states = [];
  StateItem origin = StateItem(name: '', id: 0);
  StateItem destiny = StateItem(name: '', id: 0);
  String date = '';
  List<DriverItem> drivers = [];
  DriverItem driver = DriverItem(name: '', id: 0);
  int seats = 0;

  @override
  void initState() {
    super.initState();
    dateController.text = "${fecha.toLocal()}".split(' ')[0];

    loadStates();
    loadDrivers();
  }

  void loadStates() async {
    try {
      List<StateItem> statesList = await AuthProvider().getStates();
      setState(() {
        states = statesList;
        origin = statesList[0];
        destiny = statesList[0];
      });
      print(states);
    } catch (e) {
      print('Error al cargar los estados: $e');
    }
  }

  void loadDrivers() async {
    try {
      List<DriverItem> driversList = await AuthProvider().getDriversEnabled();
      setState(() {
        drivers = driversList;
        driver = driversList[0];
      });
      print(drivers);
    } catch (e) {
      print('Error al cargar los conductores: $e');
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fecha,
      firstDate: fecha,
      lastDate: fecha.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: ColorsApp.primayColor, // header background color
              onPrimary: ColorsApp.whiteColor, // header text color
              onSurface: ColorsApp.text, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.red, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != fecha) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
        _formKey.currentState?.validate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Viajar',
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
                        setState(() {
                          _isButtonDisabled =
                              !_formKey.currentState!.validate();
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 160,
                                        child:
                                            DropdownButtonFormField<StateItem>(
                                          value: origin,
                                          decoration: InputDecoration(
                                            labelText: 'Origen*',
                                            hintText: 'Selecciona un estado',
                                            filled: true,
                                            fillColor: ColorsApp.whiteColor,
                                            hintStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            labelStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: const BorderSide(
                                                  color: ColorsApp.primayColor,
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: const BorderSide(
                                                  color: ColorsApp.primayColor,
                                                  width: 1.0),
                                            ),
                                          ),
                                          onChanged: (StateItem? newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                origin = newValue;
                                              });
                                            }
                                          },
                                          validator: (value) => value == null
                                              ? 'Campo obligatorio'
                                              : null,
                                          items: states
                                              .map<DropdownMenuItem<StateItem>>(
                                                  (StateItem state) {
                                            return DropdownMenuItem<StateItem>(
                                              value: state,
                                              child: SizedBox(
                                                  width: 80,
                                                  child: Text(state.name)),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child:
                                            DropdownButtonFormField<StateItem>(
                                          value: destiny,
                                          decoration: InputDecoration(
                                            labelText: 'Destino*',
                                            hintText: 'Selecciona un estado',
                                            filled: true,
                                            fillColor: ColorsApp.whiteColor,
                                            hintStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            labelStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: const BorderSide(
                                                  color: ColorsApp.primayColor,
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: const BorderSide(
                                                  color: ColorsApp.primayColor,
                                                  width: 1.0),
                                            ),
                                          ),
                                          onChanged: (StateItem? newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                destiny = newValue;
                                              });
                                            }
                                          },
                                          validator: (value) => value == null
                                              ? 'Campo obligatorio'
                                              : null,
                                          items: states
                                              .map<DropdownMenuItem<StateItem>>(
                                                  (StateItem state) {
                                            return DropdownMenuItem<StateItem>(
                                              value: state,
                                              child: SizedBox(
                                                  width: 100,
                                                  child: Text(state.name)),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 160,
                                        child: TextFormField(
                                          controller: dateController,
                                          onTap: () => _selectDate(context),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          cursorColor: Colors.blue,
                                          style: const TextStyle(
                                            color:
                                                Color.fromRGBO(93, 50, 86, 1),
                                          ),
                                          readOnly: true,
                                          validator: (value) {
                                            RegExp regex = RegExp(
                                                r"^(?:\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$");
                                            if (dateController.text == "") {
                                              return 'Campo obligatorio';
                                            } else if (!regex.hasMatch(
                                                dateController.text)) {
                                              return "Formato no valido";
                                            } else {
                                              DateTime fechaHoy =
                                                  DateTime.now();
                                              DateTime fechaSeleccionada =
                                                  DateTime.parse(
                                                      dateController.text);
                                              if (fechaSeleccionada.isBefore(
                                                  fechaHoy.subtract(
                                                      const Duration(
                                                          days: 1)))) {
                                                return "Fecha anterior";
                                              }
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            labelText: 'Ida*',
                                            hintText: "YYYY/mm/dd",
                                            filled: true,
                                            fillColor: ColorsApp.whiteColor,
                                            hintStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            labelStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                    color:
                                                        ColorsApp.primayColor,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                    color:
                                                        ColorsApp.primayColor,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                    color:
                                                        ColorsApp.dangerColor,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: ColorsApp
                                                                .dangerColor,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 160,
                                        child:
                                            DropdownButtonFormField<DriverItem>(
                                          value: driver,
                                          decoration: InputDecoration(
                                            labelText: 'Conductor',
                                            hintText: 'Selecciona un conductor',
                                            filled: true,
                                            fillColor: ColorsApp.whiteColor,
                                            hintStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            labelStyle: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: const BorderSide(
                                                  color: ColorsApp.primayColor,
                                                  width: 1.0),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                              borderSide: const BorderSide(
                                                  color: ColorsApp.primayColor,
                                                  width: 1.0),
                                            ),
                                          ),
                                          onChanged: (DriverItem? newValue) {
                                            if (newValue != null) {
                                              setState(() {
                                                driver = newValue;
                                              });
                                            }
                                          },
                                          validator: (value) => value == null
                                              ? 'Campo obligatorio'
                                              : null,
                                          items: drivers.map<
                                                  DropdownMenuItem<DriverItem>>(
                                              (DriverItem i) {
                                            return DropdownMenuItem<DriverItem>(
                                              value: i,
                                              child: SizedBox(
                                                  width: 80,
                                                  child: Text(i.name)),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: <TextInputFormatter>[
                                              FilteringTextInputFormatter
                                                  .digitsOnly
                                            ],
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Campo obligatorio';
                                              } else if (int.parse(value) < 0 ||
                                                  int.parse(value) > 20) {
                                                print(
                                                    "Asientos ${int.parse(value)}");
                                                return 'Coloca un valor entre 1-20';
                                              }
                                              return null;
                                            },
                                            cursorColor: ColorsApp.primayColor,
                                            style: const TextStyle(
                                              color: ColorsApp.text,
                                            ),
                                            decoration: InputDecoration(
                                              labelText: 'Asientos*',
                                              hintText: "1",
                                              filled: true,
                                              fillColor: ColorsApp.whiteColor,
                                              hintStyle: const TextStyle(
                                                color: ColorsApp.text,
                                              ),
                                              labelStyle: const TextStyle(
                                                color: ColorsApp.text,
                                              ),
                                              errorMaxLines: 2,
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          ColorsApp.primayColor,
                                                      width: 1.0,
                                                      style:
                                                          BorderStyle.solid)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          ColorsApp.primayColor,
                                                      width: 1.0,
                                                      style:
                                                          BorderStyle.solid)),
                                              errorBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0),
                                                  borderSide: const BorderSide(
                                                      color:
                                                          ColorsApp.dangerColor,
                                                      width: 1.0,
                                                      style:
                                                          BorderStyle.solid)),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.0),
                                                      borderSide:
                                                          const BorderSide(
                                                              color: ColorsApp
                                                                  .text,
                                                              width: 1.0,
                                                              style: BorderStyle
                                                                  .solid)),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                              _isButtonDisabled
                                                  ? ColorsApp.muted
                                                  : ColorsApp.primayColor,
                                            ),
                                          ),
                                          child: const Row(children: [
                                            Icon(Icons.search),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text('Buscar')
                                          ]),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                      ])
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 45,
                                backgroundImage:
                                    AssetImage('assets/images/perfilGirl.avif'),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextButton.icon(
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                  label: const Text('Detalles'),
                                  onPressed: () {
                                    _showModalInfo(context);
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorsApp.whiteColor,
                                    backgroundColor: ColorsApp.primayColor,
                                  ),
                                ),
                                TextButton.icon(
                                  icon: const Icon(CupertinoIcons.cart_fill),
                                  label: const Text('Reservar'),
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/booking');
                                  },
                                  style: TextButton.styleFrom(
                                    foregroundColor: ColorsApp.whiteColor,
                                    backgroundColor: ColorsApp.primayColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModalInfo(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return const DetailsOfTravels();
      },
    );
  }
}
