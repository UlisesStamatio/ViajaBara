import 'dart:async';
import 'dart:convert';
import 'package:flutter/src/material/card.dart' as CardFlutter;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:viajabara/domain/entities/book_trip.dart';
import 'package:viajabara/domain/entities/payment_method/payment_method.dart';
import 'package:viajabara/domain/entities/trip/trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/custom_progress_indicator.dart';
import 'package:viajabara/modules/tripsUser/adapters/methods/show_modal_info.dart';
import 'package:viajabara/modules/tripsUser/adapters/services/stripe_payment_service.dart';
import 'package:viajabara/providers/client_provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:viajabara/providers/utils/utils.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String paymentMethodSelected = "";
  late Future<void> _initialization;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  BookTrip bookTrip = BookTrip();
  TripDto tripDto = TripDto();
  List<PaymentMethodDart> paymentMethods = List.empty();
  StripePaymentService _paymentService = StripePaymentService();

  @override
  void initState() {
    super.initState();
    _initialization = _initializeData();
  }

  Future<void> _initializeData() async {
    await loadBookTrip();
    await loadTripSelected();
    paymentMethods = await ClientProvider().getPaymentMethods();
    WidgetsFlutterBinding.ensureInitialized();
    Stripe.publishableKey =
        "pk_test_51Mi0aNDr1sV9ykalIR4ehQRDU7hLcnYImfZzWRmmx9T3FL7io5VeBEZCXKWfWcJY305HxrbMZipMmKGhhIf8uqdD00qbe4sdsX";
    await Stripe.instance.applySettings();
    print(paymentMethods);
    Future.delayed(const Duration(seconds: 3), () {
      _formKey.currentState?.validate();
    });
  }

  Future<void> loadBookTrip() async {
    Completer<void> completer = Completer<void>();
    try {
      SharedPreferences prefs = await _prefs;
      if (prefs.containsKey("bookTrip")) {
        Map<String, dynamic> jsonMap = jsonDecode(prefs.getString("bookTrip")!);
        bookTrip = BookTrip.fromJson(jsonMap);
      } else {
        bookTrip = BookTrip();
        prefs.setString("bookTrip", jsonEncode(bookTrip.toJson()));
      }
      print(bookTrip);
      completer.complete();
    } catch (e) {
      print('Error loadBookTrip: $e');
      completer.completeError(e);
    }
    return completer.future;
  }

  Future<void> loadTripSelected() async {
    Completer<void> completer = Completer<void>();
    try {
      SharedPreferences prefs = await _prefs;
      if (prefs.containsKey("tripSelected")) {
        Map<String, dynamic> jsonMap =
            jsonDecode(prefs.getString("tripSelected")!);
        tripDto = TripDto.fromJson(jsonMap);
      }
      completer.complete();
    } catch (e) {
      print('Error loadTripSelected: $e');
      completer.completeError(e);
    }
    print(tripDto);
    return completer.future;
  }

  void _showModalInfo(BuildContext context, TripDto tripDto) {
    showModalInfo(context, tripDto);
  }

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
              child: FutureBuilder(
                  future: _initialization,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (paymentMethods.isEmpty) {
                        return CardFlutter.Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 40.0),
                            child: Column(
                              children: [
                                SvgPicture.asset(StuffApp.dataNotFound,
                                    height: 100),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                    "No hay métodos de pago disponibles, consulta los medios de contacto",
                                    style: TextStyle(
                                        fontSize: 13.0, fontFamily: "Tahoma"))
                              ],
                            ),
                          ),
                        );
                      } else {
                        return Form(
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
                                        icon: const Icon(
                                            Icons.remove_red_eye_outlined),
                                        label: const Text('Detalles'),
                                        onPressed: () {
                                          _showModalInfo(context, tripDto);
                                        },
                                        style: TextButton.styleFrom(
                                            foregroundColor:
                                                ColorsApp.whiteColor,
                                            backgroundColor:
                                                ColorsApp.primayColor,
                                            minimumSize: Size(
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.5,
                                              0,
                                            )),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      // ************
                                      DropdownMenu<String>(
                                        label: const Text("Tipo de Pago*"),
                                        initialSelection:
                                            paymentMethods.first.id.toString(),
                                        onSelected: (String? value) {
                                          setState(() {
                                            _initialization = Future.delayed(
                                                Duration(seconds: 2));
                                            paymentMethodSelected = value!;
                                          });
                                        },
                                        dropdownMenuEntries: paymentMethods.map<
                                                DropdownMenuEntry<String>>(
                                            (PaymentMethodDart paymentMethod) {
                                          return DropdownMenuEntry<String>(
                                              value: paymentMethod.name!
                                                  .toString(),
                                              label: paymentMethod.name!);
                                        }).toList(),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                    ])),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                    child: paymentMethodSelected == "Credito"
                                        ? GestureDetector(
                                            onTap: () {
                                              _initialization =
                                                  _paymentService.makePayment(
                                                      context,
                                                      bookTrip.price!,
                                                      paymentMethods
                                                          .firstWhere((element) =>
                                                              element.name ==
                                                              paymentMethodSelected)
                                                          .apikey!,
                                                      bookTrip);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: ColorsApp.blackColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "Total: ${Utils().formatRoutePrice(bookTrip.price!)}",
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                      const Text(
                                                        "Proceder al pago",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        : CardFlutter.Card(
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 40.0),
                                              child: Column(
                                                children: [
                                                  SvgPicture.asset(
                                                      StuffApp.waitingData,
                                                      height: 100),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                      "Selecciona un método de pago",
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          fontFamily: "Tahoma"))
                                                ],
                                              ),
                                            ),
                                          ))
                              ],
                            ));
                      }
                    } else {
                      return CustomCircularProgressIndicator();
                    }
                  }))
        ])));
  }

  Widget returnxd() {
    return CardFlutter.Card(
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
                padding: const EdgeInsets.symmetric(vertical: 20),
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
                hintText: "Diego Araith Villalobos Hernández",
                filled: true,
                fillColor: ColorsApp.whiteColor,
                hintStyle: const TextStyle(
                  color: ColorsApp.text,
                ),
                labelStyle: const TextStyle(
                  color: ColorsApp.text,
                ),
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
            SizedBox(
              height: 10,
            ),
            TextButton.icon(
              icon: const Icon(CupertinoIcons.creditcard_fill),
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
    );
  }
}
