import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/resMsg.dart';
import 'package:viajabara/domain/entities/user_data.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/validations/validations.dart';
import 'package:viajabara/providers/auth_provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _username = TextEditingController(text: '');
  final TextEditingController _pass = TextEditingController(text: '');
  final TextEditingController _repeatPass = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');

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
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
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
                    const SizedBox(height: 100),
                    SvgPicture.asset(StuffApp.logoViajabara, height: 60),
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
                              padding:
                                  const EdgeInsets.only(bottom: 10, top: 20),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  const Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Únete y viaja con nosotros',
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
                              padding: const EdgeInsets.only(bottom: 20),
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
                                controller: _username,
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
                                  labelText: 'Usuario*',
                                  hintText: "Usuario",
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
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: _email,
                                validator: (value) {
                                  RegExp regex = RegExp(Validations.email);
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obligatorio';
                                  } else if (!regex.hasMatch(value)) {
                                    return 'Introduce un correo válido';
                                  }
                                  return null;
                                },
                                cursorColor: ColorsApp.primayColor,
                                style: const TextStyle(
                                  color: ColorsApp.text,
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Correo eléctronico*',
                                  hintText: "example.com",
                                  filled: true,
                                  fillColor: ColorsApp.whiteColor,
                                  hintStyle: const TextStyle(
                                    color: ColorsApp.text,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: ColorsApp.text,
                                  ),
                                  prefixIcon: const Icon(Icons.email),
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
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: TextFormField(
                                maxLength: 10,
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
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _pass,
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
                                obscureText: !_passwordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Contraseña*',
                                  hintText: "*****",
                                  filled: true,
                                  fillColor: ColorsApp.whiteColor,
                                  hintStyle: const TextStyle(
                                    color: ColorsApp.text,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: ColorsApp.text,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _passwordVisible
                                          ? ColorsApp.text
                                          : ColorsApp.primayColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.lock,
                                      color: ColorsApp.primayColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
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
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                bottom: 10,
                              ),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                controller: _repeatPass,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Campo obligatorio';
                                  } else {
                                    if (value.toString() !=
                                        _pass.text.toString()) {
                                      return 'Las contraseñas no coinciden';
                                    }
                                    return null;
                                  }
                                },
                                cursorColor: ColorsApp.primayColor,
                                style: const TextStyle(
                                  color: ColorsApp.text,
                                ),
                                obscureText: !_repeatPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Confirmar contraseña*',
                                  hintText: "*****",
                                  filled: true,
                                  fillColor: ColorsApp.whiteColor,
                                  hintStyle: const TextStyle(
                                    color: ColorsApp.text,
                                  ),
                                  labelStyle: const TextStyle(
                                    color: ColorsApp.text,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _repeatPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _repeatPasswordVisible
                                          ? ColorsApp.text
                                          : ColorsApp.primayColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _repeatPasswordVisible =
                                            !_repeatPasswordVisible;
                                      });
                                    },
                                  ),
                                  prefixIcon: IconButton(
                                    icon: const Icon(
                                      Icons.lock,
                                      color: ColorsApp.primayColor,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _repeatPasswordVisible =
                                            !_repeatPasswordVisible;
                                      });
                                    },
                                  ),
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
                              ),
                            ),
                            ElevatedButton(
                                onPressed: _isButtonDisabled
                                    ? null
                                    : () async {
                                        UserData userData = UserData(
                                            profile: _email.text,
                                            email: _email.text,
                                            username: _username.text,
                                            password: _repeatPass.text,
                                            cellphone: _phone.text);

                                        ResMsg isRegister = await AuthProvider()
                                            .register(userData);

                                        if (!mounted) {
                                          return; // Verificar si el widget está aún montado
                                        }

                                        if (isRegister.type == 'SUCCESS') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              backgroundColor: Colors.green,
                                              content: Text(
                                                'Se registro correctamente al usuario!',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          );
                                          Navigator.pushReplacementNamed(
                                              context, '/login');
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content:
                                                      Text(isRegister.text!)));
                                        }
                                      },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
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
    );
  }
}
