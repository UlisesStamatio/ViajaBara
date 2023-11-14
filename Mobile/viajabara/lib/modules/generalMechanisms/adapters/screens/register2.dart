import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/list_states.dart';
import 'package:viajabara/domain/entities/response_message.dart';
import 'package:viajabara/domain/entities/user_data.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/providers/auth_provider.dart';

class Register2 extends StatefulWidget {
  const Register2({super.key});

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  bool _switchValueOne = false;
  bool _switchValue = false;
  String _sex = 'M';
  String email = '';
  String password = '';
  String username = '';
  int? selectedState = 1;
  List<StateItem> states = [];
  final TextEditingController _names = TextEditingController(text: '');
  final TextEditingController _lastnames = TextEditingController(text: '');
  TextEditingController _dateController = TextEditingController();
  final TextEditingController _phone = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map;
      if (arguments != null) {
        setState(() {
          email = arguments['email'];
          password = arguments['password'];
          username = arguments['username'];
        });
      }
    });

    loadStates();
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

    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
        _formKey.currentState?.validate();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Form(
                key: _formKey,
                onChanged: () {
                  setState(() {
                    _isButtonDisabled = !_formKey.currentState!.validate();
                  });
                },
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      ColorsApp.backgroundImagesColor,
                      BlendMode.color,
                    ),
                    child: SvgPicture.asset(
                      StuffApp.bgRegister,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Center(
                      child: Column(children: <Widget>[
                        const SizedBox(height: 50),
                        SvgPicture.asset(StuffApp.logoViajabara),
                        Card(
                          elevation: 4.0,
                          margin: const EdgeInsets.all(16.0),
                          color: ColorsApp.transparentColor,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: <Widget>[
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Ya casi, solo unos datos más',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: ColorsApp.muted,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          icon: const Icon(Icons.arrow_back,
                                              color: ColorsApp.primayColor),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: const Divider(
                                    color: ColorsApp.text,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: _names,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obligatorio';
                                      }
                                      return null;
                                    },
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
                                              color: ColorsApp.primayColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.dangerColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.text,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.name,
                                    controller: _lastnames,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obligatorio';
                                      } else {
                                        return null;
                                      }
                                    },
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
                                              color: ColorsApp.primayColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.dangerColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.text,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: Column(children: <Widget>[
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center, // Esto centrará el Row
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: ColorsApp.primayColor,
                                        ),
                                        SizedBox(
                                            width:
                                                8), // Esto añade un espacio entre el icono y el texto
                                        Text('Sexo*')
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Icon(
                                          Icons.male,
                                          color: !_switchValue
                                              ? ColorsApp.primayColor
                                              : ColorsApp.text,
                                        ),
                                        Text("M",
                                            style: TextStyle(
                                                color: !_switchValue
                                                    ? ColorsApp.primayColor
                                                    : ColorsApp.text)),
                                        Switch.adaptive(
                                          value: _switchValue,
                                          onChanged: (bool newValue) {
                                            setState(() {
                                              _switchValue = newValue;
                                              // Asigna 'M' si el switch está activo, si no, 'H'
                                              _sex = newValue ? 'H' : 'M';
                                            });
                                          },
                                          activeColor: ColorsApp.primayColor,
                                        ),
                                        Icon(
                                          Icons.female,
                                          color: _switchValue
                                              ? ColorsApp.primayColor
                                              : ColorsApp.text,
                                        ),
                                        Text("H",
                                            style: TextStyle(
                                                color: _switchValue
                                                    ? ColorsApp.primayColor
                                                    : ColorsApp.text)),
                                      ],
                                    ),
                                  ]),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
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
                                        if (_dateController.text == "") {
                                          return 'Campo obligatorio';
                                        } else if (!regex
                                            .hasMatch(_dateController.text)) {
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
                                              color: ColorsApp.primayColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.dangerColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.text,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: DropdownButtonFormField<int>(
                                    value: selectedState,
                                    decoration: InputDecoration(
                                      labelText: 'Estado de residencia*',
                                      hintText: 'Selecciona un estado',
                                      filled: true,
                                      fillColor: ColorsApp
                                          .whiteColor, // Reemplaza con ColorsApp.whiteColor si es necesario
                                      prefixIcon:
                                          const Icon(Icons.location_city),
                                      prefixIconColor: ColorsApp
                                          .primayColor, // Reemplaza con ColorsApp.primayColor si es necesario
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: ColorsApp.primayColor,
                                            width:
                                                1.0), // Reemplaza con ColorsApp.muted si es necesario
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        borderSide: const BorderSide(
                                            color: ColorsApp.primayColor,
                                            width:
                                                1.0), // Reemplaza con ColorsApp.primayColor si es necesario
                                      ),
                                      // Añade borderStyles adicionales según sea necesario
                                    ),
                                    onChanged: (int? newValue) {
                                      setState(() {
                                        selectedState = newValue;
                                      });
                                    },
                                    validator: (value) => value == null
                                        ? 'Campo obligatorio'
                                        : null,
                                    items: states.map<DropdownMenuItem<int>>(
                                        (StateItem state) {
                                      return DropdownMenuItem<int>(
                                        value: state.id,
                                        child: Text(state.name),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 10,
                                  ),
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Campo obligatorio';
                                      } else {
                                        return null;
                                      }
                                    },
                                    cursorColor: ColorsApp.primayColor,
                                    style: const TextStyle(
                                      color: ColorsApp.text,
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Número de teléfono',
                                      hintText: '777-111-22-33',
                                      filled: true,
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
                                              color: ColorsApp.primayColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.dangerColor,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                      focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(4.0),
                                          borderSide: const BorderSide(
                                              color: ColorsApp.text,
                                              width: 1.0,
                                              style: BorderStyle.solid)),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: _isButtonDisabled
                                        ? null
                                        : () async {
                                            UserData userData = UserData(
                                                email: email,
                                                username: username,
                                                password: password,
                                                name: _names.text,
                                                surname: _lastnames.text,
                                                birthDate: _dateController.text,
                                                state: selectedState!,
                                                cellphone: _phone.text,
                                                sex: _sex);
  
                                            ResponseMessage isRegister =await AuthProvider().register(userData);

                                            if (!mounted) {
                                              return; // Verificar si el widget está aún montado
                                            }

                                            if (isRegister.type == 'SUCCESS') {
                                              Navigator.pushReplacementNamed(
                                                  context, '/login');
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          isRegister.text)));
                                            }
                                          },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                        _isButtonDisabled
                                            ? ColorsApp.muted
                                            : ColorsApp.primayColor,
                                      ),
                                    ),
                                    child: const Text('Registrar')),
                              ],
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )
                ]))));
  }
}
