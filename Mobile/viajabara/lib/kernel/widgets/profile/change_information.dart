import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class ChangeInformation extends StatefulWidget {
  const ChangeInformation({Key? key}) : super(key: key);

  @override
  _ChangeInformation createState() => _ChangeInformation();
}

class _ChangeInformation extends State<ChangeInformation> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonDisabled = true;
  final TextEditingController _names = TextEditingController(text: '');
  final TextEditingController _lastnames = TextEditingController(text: '');
  final TextEditingController _phone = TextEditingController(text: '');

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
                    color: ColorsApp.primayColor),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.only(
                  bottom: 25,
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
                  bottom: 25,
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
                  bottom: 25,
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
                    onPressed: _isButtonDisabled ? null : () => {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        _isButtonDisabled
                            ? ColorsApp.muted
                            : ColorsApp.primayColor,
                      ),
                    ),
                    child: const Text('Actualizar información')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
