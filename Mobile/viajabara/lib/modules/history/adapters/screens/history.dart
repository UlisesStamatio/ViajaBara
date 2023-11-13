import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/modules/history/adapters/screens/historyStars.dart';
import 'package:viajabara/modules/historyUser/adapters/screens/historyUser.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Historial',
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
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SvgPicture.asset(
              StuffApp.bgGeneral,
              fit: BoxFit.cover,
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        // Segunda fila con lista de textos (2 por fila)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinear a la izquierda
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Espaciado uniforme
                            children: <Widget>[
                              Text('Salida : Lugar YYYY/mm/dd HH:MM',
                                  style: TextStyle(
                                      fontSize: 15.0, color: ColorsApp.text)),
                              Text(
                                'Llegada : Lugar YYYY/mm/dd HH:MM',
                                style: TextStyle(
                                    fontSize: 15.0, color: ColorsApp.text),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: FractionallySizedBox(
                              widthFactor: 0.75,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HistoryStars()));
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorsApp.primayColor),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinear a la izquierda
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Espaciado uniforme
                            children: <Widget>[
                              Text('Salida : Lugar YYYY/mm/dd HH:MM',
                                  style: TextStyle(
                                      fontSize: 15.0, color: ColorsApp.text)),
                              Text(
                                'Llegada : Lugar YYYY/mm/dd HH:MM',
                                style: TextStyle(
                                    fontSize: 15.0, color: ColorsApp.text),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: FractionallySizedBox(
                              widthFactor: 0.75,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorsApp.primayColor),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinear a la izquierda
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Espaciado uniforme
                            children: <Widget>[
                              Text('Salida : Lugar YYYY/mm/dd HH:MM',
                                  style: TextStyle(
                                      fontSize: 15.0, color: ColorsApp.text)),
                              Text(
                                'Llegada : Lugar YYYY/mm/dd HH:MM',
                                style: TextStyle(
                                    fontSize: 15.0, color: ColorsApp.text),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Align(
                            alignment: Alignment.center,
                            child: FractionallySizedBox(
                              widthFactor: 0.75,
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorsApp.primayColor),
                                ),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
