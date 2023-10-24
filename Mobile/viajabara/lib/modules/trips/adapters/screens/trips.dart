import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';

import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';
import 'package:viajabara/kernel/validations/validations.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    color: ColorsApp.bgColorScreen,
                    alignment: Alignment.centerRight,
                    width:
                        double.infinity, // Ocupa todo el ancho de la pantalla
                    child: Image.asset(
                      'assets/images/viajabara_logo_purple.png',
                      width: 200,
                      height: 50,
                    ),
                  ),

                  // *************************************
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        // Primera fila con icono y descripción
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Column(
                            children: <Widget>[
                              Icon(Icons.bus_alert, size: 28.0),
                              Text('Horario'),
                            ],
                          ),
                        ),
                        // Segunda fila con lista de textos (2 por fila)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 125.0,
                          child: GridView.builder(
                            shrinkWrap: false,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 5,
                              crossAxisCount: 2,
                            ),
                            itemCount: 5,
                            itemBuilder: (context, index) {
                              return Text('Texto ${index + 1}');
                            },
                          ),
                        ),
                        // Tercera fila con dos botones
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorsApp.primayColor)),
                                child: const Row(children: [
                                  Icon(Icons.remove_red_eye_outlined),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Detalles')
                                ]),
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorsApp.primayColor)),
                                child: const Row(children: [
                                  Icon(Icons.play_arrow),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('En curso')
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  // *************************************
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
