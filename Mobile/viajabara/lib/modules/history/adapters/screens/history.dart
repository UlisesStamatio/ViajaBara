import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
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
                        // Segunda fila con lista de textos (2 por fila)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 70.0,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinear a la izquierda
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Espaciado uniforme
                            children: <Widget>[
                              Text('Salida : Lugar YYYY/mm/dd HH:MM',
                                  style: TextStyle(fontSize: 15.0)),
                              Text(
                                'Llegada : Lugar YYYY/mm/dd HH:MM',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        // Tercera fila con dos botones
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
                                      size: 22,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 15.0),
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
                        // Segunda fila con lista de textos (2 por fila)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 70.0,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinear a la izquierda
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Espaciado uniforme
                            children: <Widget>[
                              Text('Salida : Lugar YYYY/mm/dd HH:MM',
                                  style: TextStyle(fontSize: 15.0)),
                              Text(
                                'Llegada : Lugar YYYY/mm/dd HH:MM',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        // Tercera fila con dos botones
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
                                      size: 22,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 15.0),
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
                        // Segunda fila con lista de textos (2 por fila)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          height: 70.0,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment
                                .start, // Alinear a la izquierda
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, // Espaciado uniforme
                            children: <Widget>[
                              Text('Salida : Lugar YYYY/mm/dd HH:MM',
                                  style: TextStyle(fontSize: 15.0)),
                              Text(
                                'Llegada : Lugar YYYY/mm/dd HH:MM',
                                style: TextStyle(fontSize: 15.0),
                              ),
                            ],
                          ),
                        ),
                        // Tercera fila con dos botones
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
                                      size: 22,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 15.0),
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
