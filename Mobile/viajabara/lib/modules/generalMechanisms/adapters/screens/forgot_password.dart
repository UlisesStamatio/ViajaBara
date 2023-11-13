import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/validations/validations.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  bool _passwordVisible = false;
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _pass = TextEditingController(text: '');

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
                  StuffApp.bgRecover,
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
                                'Recupera tu acceso',
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
                                  labelText: 'Correo electrónico*',
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
                            ElevatedButton(
                                onPressed: _isButtonDisabled
                                    ? null
                                    : () => Navigator.pushReplacementNamed(
                                        context, '/menu'),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    _isButtonDisabled
                                        ? ColorsApp.muted
                                        : ColorsApp.primayColor,
                                  ),
                                ),
                                child: const Text('Enviar Correo')),
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
