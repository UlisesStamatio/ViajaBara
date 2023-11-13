import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

const List<String> list = <String>[
  'Tarjeta Crédito / Débito',
  'Efectivo',
  'Paypal'
];

class _PaymentState extends State<Payment> {
  String dropdownValue = list.first;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Pagar',
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: ColorsApp.primayColor),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SafeArea(
            child: Stack(fit: StackFit.expand, children: <Widget>[
          SvgPicture.asset(
            StuffApp.bgGeneral,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  onChanged: () {
                    // setState(() {
                    //   _isButtonDisabled =
                    //       !_formKey.currentState!.validate();
                    // });
                  },
                  child: Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Column(children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            TextButton.icon(
                              icon: const Icon(Icons.remove_red_eye_outlined),
                              label: const Text('Detalles'),
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                  foregroundColor: ColorsApp.whiteColor,
                                  backgroundColor: ColorsApp.primayColor,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width / 1.5,
                                    0,
                                  )),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            // ************
                            DropdownMenu<String>(
                              label: const Text("Tipo de Pago*"),
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
                              width: MediaQuery.of(context).size.width / 1.2,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                          ])),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Card(
                          margin: const EdgeInsets.all(20),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(CupertinoIcons.creditcard_fill),
                                    Icon(CupertinoIcons.creditcard_fill),
                                    Icon(CupertinoIcons.creditcard_fill),
                                    Icon(CupertinoIcons.creditcard_fill),
                                  ],
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    child: const Text("Pago Total: \$300.0")),
                                TextFormField(
                                  keyboardType: TextInputType.name,
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
                                    labelText: 'Nombre*',
                                    hintText:
                                        "Diego Araith Villalobos Hernández",
                                    filled: true,
                                    fillColor: ColorsApp.whiteColor,
                                    hintStyle: const TextStyle(
                                      color: ColorsApp.text,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: ColorsApp.text,
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
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
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
                                    labelText: 'Tarjeta*',
                                    hintText: "1111 2222 3333 4444",
                                    filled: true,
                                    fillColor: ColorsApp.whiteColor,
                                    hintStyle: const TextStyle(
                                      color: ColorsApp.text,
                                    ),
                                    labelStyle: const TextStyle(
                                      color: ColorsApp.text,
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
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton.icon(
                                  icon: const Icon(
                                      CupertinoIcons.creditcard_fill),
                                  label: const Text('Pagar'),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      foregroundColor: ColorsApp.whiteColor,
                                      backgroundColor: ColorsApp.primayColor,
                                      minimumSize: Size(
                                        MediaQuery.of(context).size.width / 1.5,
                                        0,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )))
        ])));
  }
}
