import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

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
                                  const SizedBox(
                                    height: 20.0,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        SizedBox(
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
                                                      color: ColorsApp.muted,
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
                                        Spacer(),
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
                                        SizedBox(
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
                                  onPressed: () {},
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
}
