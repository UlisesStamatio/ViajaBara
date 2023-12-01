import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/resMsg.dart';
import 'package:viajabara/kernel/cubits/login/login_form_cubit.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/validations/validations.dart';
import 'package:viajabara/providers/auth_provider.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  bool _passwordVisible = false;
  bool _islogged = false;
  final TextEditingController _email =
      TextEditingController(text: '20203tn159@utez.edu.mx');
  final TextEditingController _pass = TextEditingController(text: 'Admin123');

  @override
  Widget build(BuildContext context) {
    final loginFormCubit = context.watch<LoginFormCubit>();
    return Scaffold(
      body: Form(
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
                StuffApp.bgLogin,
                fit: BoxFit.cover,
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(children: <Widget>[
                  const SizedBox(height: 120),
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
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: const Text(
                              '¡Bienvenido!',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorsApp.text),
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
                              keyboardType: TextInputType.emailAddress,
                              // onChanged: (value) {
                              //   loginFormCubit.usernameChanged(value);
                              //   _formKey.currentState?.validate();
                              // },
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
                                labelText: 'Usuario o correo*',
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
                              bottom: 20,
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              // onChanged: (value) {
                              //   loginFormCubit.passwordChanged(value);
                              //   _formKey.currentState?.validate();
                              // },
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
                          Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/forgotPassword'),
                                    child: const Text(
                                      '¿Olvidaste tu contraseña?',
                                      style: TextStyle(
                                          color: ColorsApp.primayColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Stack(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const Expanded(
                                          child: Divider(color: Colors.grey),
                                        ),
                                        Container(
                                          color: Colors
                                              .white, // El color de fondo del Stack
                                          child: const Text(
                                            'O',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        const Expanded(
                                          child: Divider(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                    onTap: () => Navigator.pushNamed(
                                        context, '/register'),
                                    child: const Text(
                                      '¿Aún no te has registrado?',
                                      style: TextStyle(
                                        color: ColorsApp.primayColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: _isButtonDisabled
                                ? null
                                : () async {
                                    setState(() {
                                      _isButtonDisabled = true;
                                    });

                                    ResMsg isLogged =
                                        await AuthProvider()
                                            .login(_email.text, _pass.text);

                                    if (!mounted) {
                                      return; // Verificar si el widget está aún montado
                                    }

                                    if (isLogged.token != null) {
                                      setState(() {
                                        _islogged = true;
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Usuario o contraseña incorrectos')),
                                      );
                                    }

                                    if (_islogged) {
                                      Navigator.pushNamed(context, '/menu',
                                          arguments: {
                                            'rol': isLogged.roles?.keyRole,
                                          });
                                    }

                                    setState(() {
                                      _isButtonDisabled = false;
                                    });
                                  },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                _isButtonDisabled
                                    ? ColorsApp.muted
                                    : ColorsApp.primayColor,
                              ),
                            ),
                            child: const Text('Iniciar sesión'),
                          )
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
      bottomNavigationBar: null,
    );
  }
}
