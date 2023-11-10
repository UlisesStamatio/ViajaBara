import 'package:flutter/material.dart';
import 'package:viajabara/domain/entities/user_data.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
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
  final TextEditingController _names = TextEditingController(text: '');
  final TextEditingController _lastnames = TextEditingController(text: '');
  final TextEditingController _birthday = TextEditingController(text: '');
  final TextEditingController _residentState = TextEditingController(text: '');
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
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              // ********
              // SingleChildScrollView(
              //   child: Center(
              //     child: Column(children: <Widget>[
              //       const SizedBox(height: 120),
              child: IntrinsicHeight(
                child: Stack(
                  children: <Widget>[
                    // ********
                    // Tu fondo y otros widgets que no están posicionados
                    // vienen aquí.
                    Image.asset(
                      'assets/images/bg.png',
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                    ),
                    // ********
                    // Card(
                    //   elevation: 4.0,
                    //   margin: const EdgeInsets.all(16.0),
                    //   child: Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: <Widget>[
                    //         Container(
                    //           padding: const EdgeInsets.symmetric(vertical: 20),
                    //           child: const Text(
                    //             'Ya falta poco',
                    //             style: TextStyle(
                    //                 fontSize: 16,
                    //                 fontWeight: FontWeight.bold,
                    //                 color: ColorsApp.text),
                    //           ),
                    //         ),
                    //         Container(
                    //           padding: const EdgeInsets.only(bottom: 20),
                    //           child: const Divider(
                    //             color: ColorsApp.text,
                    //           ),
                    //         ),
                    //         Container(
                    //           padding: const EdgeInsets.only(
                    //             bottom: 20,
                    //           ),
                    //           child: TextFormField(
                    //             keyboardType: TextInputType.name,
                    //             controller: _names,
                    //             validator: (value) {
                    //               if (value == null || value.isEmpty) {
                    //                 return 'Campo obligatorio';
                    //               }
                    //               return null;
                    //             },
                    //             cursorColor: ColorsApp.primayColor,
                    //             style: const TextStyle(
                    //               color: ColorsApp.text,
                    //             ),
                    //             decoration: InputDecoration(
                    //               labelText: 'Nombre(s)*',
                    //               hintText: "Keanu",
                    //               filled: true,
                    //               fillColor: ColorsApp.whiteColor,
                    //               hintStyle: const TextStyle(
                    //                 color: ColorsApp.muted,
                    //               ),
                    //               labelStyle: const TextStyle(
                    //                 color: ColorsApp.muted,
                    //               ),
                    //               prefixIcon: const Icon(Icons.person),
                    //               prefixIconColor: ColorsApp.primayColor,
                    //               enabledBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.muted,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //               focusedBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.primayColor,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //               errorBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.dangerColor,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //               focusedErrorBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.muted,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           padding: const EdgeInsets.only(
                    //             bottom: 20,
                    //           ),
                    //           child: TextFormField(
                    //             keyboardType: TextInputType.name,
                    //             controller: _lastnames,
                    //             validator: (value) {
                    //               if (value!.isEmpty) {
                    //                 return 'Campo obligatorio';
                    //               } else {
                    //                 return null;
                    //               }
                    //             },
                    //             cursorColor: ColorsApp.primayColor,
                    //             style: const TextStyle(
                    //               color: ColorsApp.text,
                    //             ),
                    //             decoration: InputDecoration(
                    //               labelText: 'Apellidos*',
                    //               hintText: "Reeves",
                    //               filled: true,
                    //               fillColor: ColorsApp.whiteColor,
                    //               hintStyle: const TextStyle(
                    //                 color: ColorsApp.muted,
                    //               ),
                    //               labelStyle: const TextStyle(
                    //                 color: ColorsApp.muted,
                    //               ),
                    //               prefixIcon: const Icon(Icons.person),
                    //               prefixIconColor: ColorsApp.primayColor,
                    //               enabledBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.muted,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //               focusedBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.primayColor,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //               errorBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.dangerColor,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //               focusedErrorBorder: OutlineInputBorder(
                    //                   borderRadius: BorderRadius.circular(4.0),
                    //                   borderSide: const BorderSide(
                    //                       color: ColorsApp.muted,
                    //                       width: 1.0,
                    //                       style: BorderStyle.solid)),
                    //             ),
                    //           ),
                    //         ),
                    //         Container(
                    //           padding: const EdgeInsets.only(
                    //             bottom: 20,
                    //           ),
                    //           child: Column(children: <Widget>[
                    //             const Row(
                    //                 mainAxisSize: MainAxisSize.max,
                    //                 children: [
                    //                   Icon(
                    //                     Icons.person,
                    //                     color: ColorsApp.primayColor,
                    //                   ),
                    //                   Text(
                    //                     'Sexo*',
                    //                     style:
                    //                         TextStyle(color: ColorsApp.muted),
                    //                   )
                    //                 ]),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceAround,
                    //               mainAxisSize: MainAxisSize.max,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Icon(
                    //                       Icons.male,
                    //                       color: !_switchValueOne
                    //                           ? ColorsApp.primayColor
                    //                           : ColorsApp.text,
                    //                     ),
                    //                     Text("H",
                    //                         style: TextStyle(
                    //                             color: !_switchValueOne
                    //                                 ? ColorsApp.primayColor
                    //                                 : ColorsApp.text)),
                    //                     Switch.adaptive(
                    //                       value: !_switchValueOne,
                    //                       onChanged: (bool newValue) =>
                    //                           setState(() {
                    //                         _sex = "H";
                    //                         _switchValueOne = newValue;
                    //                       }),
                    //                       activeColor: ColorsApp.primayColor,
                    //                     ),
                    //                   ],
                    // ********
                    // Tus widgets posicionados vienen aquí.
                    Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Column(children: <Widget>[
                          Image.asset(
                            'assets/images/viajabara_logo.png',
                            height: 60,
                          ),
                          Card(
                            elevation: 4.0,
                            margin: const EdgeInsets.all(16.0),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        bottom: 40, top: 20),
                                    child: const Text(
                                      'Únete y viaja de volada',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ColorsApp.muted),
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
                                          color: ColorsApp.muted,
                                        ),
                                        labelStyle: const TextStyle(
                                          color: ColorsApp.muted,
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
                                                color: ColorsApp.errorColor,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                                color: ColorsApp.muted,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
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
                                          color: ColorsApp.muted,
                                        ),
                                        labelStyle: const TextStyle(
                                          color: ColorsApp.muted,
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
                                                color: ColorsApp.errorColor,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                                color: ColorsApp.muted,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
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
                                      bottom: 20,
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.datetime,
                                      controller: _birthday,
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
                                        labelText: 'Fecha de nacimiento*',
                                        filled: true,
                                        fillColor: ColorsApp.whiteColor,
                                        hintStyle: const TextStyle(
                                          color: ColorsApp.muted,
                                        ),
                                        labelStyle: const TextStyle(
                                          color: ColorsApp.muted,
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
                                                color: ColorsApp.errorColor,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                                color: ColorsApp.muted,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
                                    ),
                                    child: TextFormField(
                                      keyboardType: TextInputType.streetAddress,
                                      controller: _residentState,
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
                                        labelText: 'Estado de residencia*',
                                        hintText: 'Morelos',
                                        filled: true,
                                        fillColor: ColorsApp.whiteColor,
                                        hintStyle: const TextStyle(
                                          color: ColorsApp.muted,
                                        ),
                                        labelStyle: const TextStyle(
                                          color: ColorsApp.muted,
                                        ),
                                        prefixIcon:
                                            const Icon(Icons.location_city),
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
                                                color: ColorsApp.errorColor,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                                color: ColorsApp.muted,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      bottom: 20,
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
                                          color: ColorsApp.muted,
                                        ),
                                        labelStyle: const TextStyle(
                                          color: ColorsApp.muted,
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
                                                color: ColorsApp.errorColor,
                                                width: 1.0,
                                                style: BorderStyle.solid)),
                                        focusedErrorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                            borderSide: const BorderSide(
                                                color: ColorsApp.muted,
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
                                                  birthDate: _birthday.text,
                                                  state: _residentState.text,
                                                  cellphone: _phone.text,
                                                  sex: _sex);

                                              bool isRegister =
                                                  await AuthProvider()
                                                      .register(userData);

                                              if (!mounted) {
                                                return; // Verificar si el widget está aún montado
                                              }

                                              if (isRegister) {
                                                Navigator.pushReplacementNamed(
                                                    context, '/login');
                                              } else {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                        'Hubo un error al registrar el usuario'),
                                                  ),
                                                );
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
