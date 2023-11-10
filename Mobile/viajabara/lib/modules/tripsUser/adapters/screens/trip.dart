import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

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

  @override
  void initState() {
    super.initState();
    dateController.text = "${fecha.toLocal()}".split(' ')[0];
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
        foregroundColor: ColorsApp.muted2,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'assets/images/viajabara_logo_purple.png',
              width: 100,
              height: 50,
              color: ColorsApp.primayColor,
            ),
          ),
        ],
        backgroundColor: ColorsApp.whiteColor,
        shadowColor: ColorsApp.blackColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // *************************************
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: ColorsApp.whiteColor,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Form(
                      key: _formKey,
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
                                      DropdownMenu<String>(
                                        label: const Text("Origen*"),
                                        initialSelection: list.first,
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValue = value!;
                                          });
                                        },
                                        dropdownMenuEntries: list
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                        width: 160,
                                      ),
                                      DropdownMenu<String>(
                                        label: const Text("Destino*"),
                                        initialSelection: list.first,
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValue = value!;
                                          });
                                        },
                                        dropdownMenuEntries: list
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                        width: 160,
                                      )
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
                                              color: ColorsApp.muted,
                                            ),
                                            labelStyle: const TextStyle(
                                              color: ColorsApp.muted,
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                    color: ColorsApp.muted,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                    color: ColorsApp.muted,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4.0),
                                                borderSide: const BorderSide(
                                                    color: ColorsApp.errorColor,
                                                    width: 1.0,
                                                    style: BorderStyle.solid)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color:
                                                                ColorsApp.muted,
                                                            width: 1.0,
                                                            style: BorderStyle
                                                                .solid)),
                                          ),
                                        ),
                                      ),
                                      DropdownMenu<String>(
                                        label: const Text("Conductor*"),
                                        initialSelection: list.first,
                                        onSelected: (String? value) {
                                          // This is called when the user selects an item.
                                          setState(() {
                                            dropdownValue = value!;
                                          });
                                        },
                                        dropdownMenuEntries: list
                                            .map<DropdownMenuEntry<String>>(
                                                (String value) {
                                          return DropdownMenuEntry<String>(
                                              value: value, label: value);
                                        }).toList(),
                                        width: 160,
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          Container(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorsApp.primayColor)),
                                  child: const Row(children: [
                                    Icon(Icons.remove_red_eye_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('Detalles')
                                  ]),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              ColorsApp.primayColor)),
                                  child: const Row(children: [
                                    Icon(Icons.play_arrow),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text('En curso')
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Column(
                            children: <Widget>[
                              Icon(CupertinoIcons.bus, size: 50.0),
                              Text('Horario'),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            height: 100.0,
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Salida: 2:00 a.m',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      'Llegada: 6:30 p.m',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Tiempo estimado: 4:30hrs',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: ColorsApp.primayColor),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Destino: Veracruz',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      '1 Escala   - Local',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const Trip()),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorsApp.primayColor),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.remove_red_eye_outlined),
                                SizedBox(width: 10),
                                Text('Detalles')
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                  // *************************************
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
