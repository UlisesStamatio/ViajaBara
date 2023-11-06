import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

import 'package:viajabara/modules/trips/adapters/screens/traveling.dart';

class Trips extends StatefulWidget {
  const Trips({super.key});

  @override
  State<Trips> createState() => _TripsState();
}

class _TripsState extends State<Trips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Viajes',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        foregroundColor: ColorsApp.muted2,
        actions: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Image.asset(
              'assets/images/viajabara_logo_purple.png',
              width: 100,
              height: 50,
              color: ColorsApp.primayColor,
            ),
          ),
        ],
        backgroundColor: ColorsApp.whiteColor,
        shadowColor: ColorsApp.blackColor,
        elevation: 2,
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/images/bg.png',
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // *************************************
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Column(
                            children: <Widget>[
                              Icon(CupertinoIcons.bus, size: 50.0),
                              Text('Horario'),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            height: 100.0,
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Salida: 8:30 a.m',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      'Llegada: 12:30 p.m',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Tiempo estimado: 4hrs',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: ColorsApp.primayColor),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Destino: Guadalajara',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      'Directo - Local',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(15),
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
                                onPressed: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const Traveling()),
                                ),
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
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: const Column(
                            children: <Widget>[
                              Icon(CupertinoIcons.bus, size: 50.0),
                              Text('Horario'),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 20),
                            height: 100.0,
                            child: const Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Salida: 2:00 a.m',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      'Llegada: 6:30 p.m',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      'Tiempo estimado: 4:30hrs',
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          color: ColorsApp.primayColor),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      'Destino: Veracruz',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    Text(
                                      '1 Escala   - Local',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ColorsApp.primayColor),
                            ),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.remove_red_eye_outlined),
                                SizedBox(width: 10),
                                Text('Detalles')
                              ],
                            ),
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
