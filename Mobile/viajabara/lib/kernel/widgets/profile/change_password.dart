import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/general_provider.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  bool _lastPassVisible = false;
  bool _isButtonDisabled = true;
  bool _passwordVisible = false;
  bool _repeatPasswordVisible = false;

  final TextEditingController _lastPass = TextEditingController(text: '');
  final TextEditingController _pass = TextEditingController(text: '');
  final TextEditingController _repeatPass = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        onChanged: () {
          setState(() {
            _isButtonDisabled = !_formKey.currentState!.validate();
          });
        },
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                'Cambiar contraseña',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.text),
              ),
              const SizedBox(height: 10),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Divider(color: ColorsApp.text)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _lastPass,
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
                  obscureText: !_lastPassVisible,
                  decoration: InputDecoration(
                    labelText: 'Contraseña Anterior*',
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
                        _lastPassVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: _lastPassVisible
                            ? ColorsApp.text
                            : ColorsApp.primayColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _lastPassVisible = !_lastPassVisible;
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
                          _lastPassVisible = !_lastPassVisible;
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
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
                    labelText: 'Contraseña nueva*',
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
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  controller: _repeatPass,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obligatorio';
                    } else {
                      if (value.toString() != _pass.text.toString()) {
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
                          _repeatPasswordVisible = !_repeatPasswordVisible;
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
                          _repeatPasswordVisible = !_repeatPasswordVisible;
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
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    onPressed: _isButtonDisabled ? null : () async  {
                      bool resp =  await GeneralProvider().changePassword(_lastPass.text, _pass.text);
                      if(resp)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Contraseña actualizada correctamente'),
                            backgroundColor: ColorsApp.successColor,
                          ),
                        );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _isButtonDisabled
                            ? ColorsApp.muted
                            : ColorsApp.primayColor,
                      ),
                    ),
                    child: const Text('Actualizar contraseña')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
