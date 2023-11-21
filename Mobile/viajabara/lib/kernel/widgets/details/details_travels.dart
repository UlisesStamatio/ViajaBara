import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class DetailsOfTravels extends StatefulWidget {
  const DetailsOfTravels({Key? key}) : super(key: key);

  @override
  _DetailsOfTravels createState() => _DetailsOfTravels();
}

class _DetailsOfTravels extends State<DetailsOfTravels> {
  final photo = 'assets/images/perfilGirl.avif';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const SizedBox(height: 20),
                const Text(
                  'Detalles del viaje',
                  style: TextStyle(
                    color: ColorsApp.primayColor,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                  child: const Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Origen: Acapulco',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.flight_land, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Destino: Guadalajara',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.date_range, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Fecha: 03/08/2024',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.timeline, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Escala(s): 1',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Hora de salida: 07:00 a.m.',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.access_time, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text('Hora de llegada: 11:00 a.m.',
                              style: TextStyle(
                                color: ColorsApp.text,
                                fontSize: 16.0,
                              ))
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.timer, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Tiempo estimado: 4:20 hrs.',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(Icons.person, color: ColorsApp.text, size: 35,),
                          SizedBox(width: 10),
                          Text(
                            'Número de pasajeros: 22',
                            style: TextStyle(
                              color: ColorsApp.text,
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ])),
        ],
      ),
    );
  }
}
