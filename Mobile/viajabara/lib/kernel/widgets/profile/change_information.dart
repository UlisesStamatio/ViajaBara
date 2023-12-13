import 'package:flutter/material.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/auth_provider.dart';
import 'package:viajabara/providers/general_provider.dart';

class ChangeInformation extends StatefulWidget {
  final Function? onUpdate;
  const ChangeInformation({Key? key, this.onUpdate}) : super(key: key);

  @override
  _ChangeInformation createState() => _ChangeInformation();
}

class _ChangeInformation extends State<ChangeInformation> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  bool _isLoading = false;
  int? selectedState;
  List<StateItem> states = [];
  final TextEditingController _names = TextEditingController(text: '');
  final TextEditingController _lastnames = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');
  TextEditingController _dateController = TextEditingController();
  String? _selectedSex;
  final Map<String, String?> sexOptions = {
    'Selecciona tu sexo': null,
    'Femenino': 'M',
    'Masculino': 'H',
  };

  @override
  void initState() {
    super.initState();
    loadStates();
  }

  void _checkIfAnyFieldIsFilled() {
    bool isAnyFieldFilled = _names.text.isNotEmpty ||
        _lastnames.text.isNotEmpty ||
        _phone.text.isNotEmpty ||
        _dateController.text.isNotEmpty ||
        selectedState != null ||
        (_selectedSex != null && _selectedSex!.isNotEmpty);

    setState(() {
      _isButtonDisabled = !isAnyFieldFilled;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002, 07, 08),
      firstDate: DateTime(1973, 1, 1),
      lastDate: DateTime(2005, 12, 31),
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

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
        _formKey.currentState?.validate();
      });
    }
  }

  void loadStates() async {
    try {
      List<StateItem> statesList = await AuthProvider().getStates();
      setState(() {
        states = statesList;
      });
    } catch (e) {
      print('Error al cargar los estados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        onChanged: () {
          _checkIfAnyFieldIsFilled();
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Modificar información personal',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.text),
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Divider(color: ColorsApp.text)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _names,
                  cursorColor: ColorsApp.primayColor,
                  style: const TextStyle(
                    color: ColorsApp.text,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Nombre(s)*',
                    hintText: "Keanu",
                    filled: true,
                    fillColor: ColorsApp.whiteColor,
                    hintStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    labelStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: ColorsApp.primayColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.muted,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.primayColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.dangerColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.text,
                            width: 1.0,
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (value) {
                    _checkIfAnyFieldIsFilled();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: _lastnames,
                  cursorColor: ColorsApp.primayColor,
                  style: const TextStyle(
                    color: ColorsApp.text,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Apellidos*',
                    hintText: "Reeves",
                    filled: true,
                    fillColor: ColorsApp.whiteColor,
                    hintStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    labelStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: ColorsApp.primayColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.muted,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.primayColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.dangerColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.text,
                            width: 1.0,
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (value) {
                    _checkIfAnyFieldIsFilled();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<String>(
                  value: _selectedSex,
                  decoration: InputDecoration(
                    labelText: 'Sexo',
                    hintText: 'Selecciona tu sexo',
                    filled: true,
                    fillColor: ColorsApp.whiteColor,
                    hintStyle: const TextStyle(color: ColorsApp.text),
                    labelStyle: const TextStyle(color: ColorsApp.text),
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: ColorsApp.primayColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.muted,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.primayColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.dangerColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.text,
                            width: 1.0,
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedSex = newValue;
                    });
                    _checkIfAnyFieldIsFilled();
                  },
                  items:
                      sexOptions.entries.map<DropdownMenuItem<String>>((entry) {
                    return DropdownMenuItem<String>(
                      value: entry.value,
                      child: Text(entry.key),
                    );
                  }).toList(),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: TextFormField(
                  controller: _dateController,
                  onTap: () => _selectDate(context),
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.blue,
                  style: const TextStyle(
                    color: Color.fromRGBO(93, 50, 86, 1),
                  ),
                  readOnly: true,
                  validator: (value) {
                    RegExp regex = RegExp(
                        r"^(?:\d{4}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))$");
                    if (!regex.hasMatch(_dateController.text)) {
                      return "Formato no valido";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Fecha de nacimiento*',
                    filled: true,
                    fillColor: ColorsApp.whiteColor,
                    hintStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    labelStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    prefixIcon: const Icon(Icons.cake),
                    prefixIconColor: ColorsApp.primayColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.muted,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.primayColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.dangerColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.text,
                            width: 1.0,
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (value) {
                    _checkIfAnyFieldIsFilled();
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: DropdownButtonFormField<int?>(
                    value: selectedState,
                    decoration: InputDecoration(
                      labelText: 'Estado de residencia*',
                      hintText: 'Selecciona un estado',
                      hintStyle: const TextStyle(
                        color: ColorsApp.text,
                      ),
                      labelStyle: const TextStyle(
                        color: ColorsApp.text,
                      ),
                      filled: true,
                      fillColor: ColorsApp.whiteColor,
                      prefixIcon: const Icon(Icons.location_city),
                      prefixIconColor: ColorsApp.primayColor,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.muted, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.primayColor, width: 1.0),
                      ),
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        selectedState = newValue;
                      });
                      _checkIfAnyFieldIsFilled();
                    },
                    items: [
                      const DropdownMenuItem<int?>(
                        value: null,
                        child: Text("Selecciona un estado"),
                      ),
                      ...states.map<DropdownMenuItem<int?>>((StateItem state) {
                        return DropdownMenuItem<int?>(
                          value: state.id,
                          child: Text(state.name),
                        );
                      }).toList(),
                    ]),
              ),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: _phone,
                  cursorColor: ColorsApp.primayColor,
                  style: const TextStyle(
                    color: ColorsApp.text,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Número de teléfono',
                    hintText: '7771112233',
                    filled: true,
                    counterText: '',
                    fillColor: ColorsApp.whiteColor,
                    hintStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    labelStyle: const TextStyle(
                      color: ColorsApp.text,
                    ),
                    prefixIcon: const Icon(Icons.phone),
                    prefixIconColor: ColorsApp.primayColor,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.muted,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.primayColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.dangerColor,
                            width: 1.0,
                            style: BorderStyle.solid)),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        borderSide: const BorderSide(
                            color: ColorsApp.text,
                            width: 1.0,
                            style: BorderStyle.solid)),
                  ),
                  onChanged: (value) {
                    _checkIfAnyFieldIsFilled();
                  },
                  maxLength: 10,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    onPressed: _isButtonDisabled
                        ? null
                        : () async {
                            try {
                              setState(() {
                                _isLoading = true;
                              });
                              bool result =
                                  await GeneralProvider().updateUserInfo(
                                _names.text.isNotEmpty ? _names.text : null,
                                _lastnames.text.isNotEmpty
                                    ? _lastnames.text
                                    : null,
                                _selectedSex != null ? _selectedSex : null,
                                _dateController.text.isNotEmpty
                                    ? _dateController.text
                                    : null,
                                selectedState != null ? selectedState : null,
                                _phone.text.isNotEmpty ? _phone.text : null,
                              );

                              setState(() {
                                _isLoading = false;
                              });

                              if (result) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Text(
                                      'Se actualizo correctamente la información!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                                if (widget.onUpdate != null) {
                                  widget.onUpdate!(); // Llama al callback aquí
                                }
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                      'Ocurrió un error al actualizar la información',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            } catch (e) {
                              setState(() {
                                _isLoading = false;
                              });
                              print('Error al actualizar la información: $e');
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _isButtonDisabled
                            ? ColorsApp.muted
                            : ColorsApp.primayColor,
                      ),
                    ),
                    child: const Text('Actualizar información')),
              ),
              if (_isLoading) const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
