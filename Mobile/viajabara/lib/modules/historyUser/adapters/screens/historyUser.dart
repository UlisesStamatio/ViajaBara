import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart'; // Asegúrate de que esta ruta sea correcta

class HistoryUser extends StatefulWidget {
  const HistoryUser({Key? key}) : super(key: key);

  @override
  State<HistoryUser> createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
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
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/viajabara_logo_purple.png',
                      width: 200,
                      height: 50,
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: NetworkImage(
                                    'https://cdn.icon-icons.com/icons2/1999/PNG/512/avatar_people_person_profile_student_user_icon_123383.png'),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Salida: Lugar HH:MM',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Llegada: Lugar HH:MM',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Pagado: \$100.0',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextButton.icon(
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                  label: const Text('Detalles'),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: ColorsApp.primayColor,
                                      minimumSize: const Size(150, 40)),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.thumb_up_outlined),
                                  label: const Text('Calificar'),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: ColorsApp.primayColor,
                                      minimumSize: const Size(150, 40)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                    'assets/images/Girl.png'),
                              ),
                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Salida: Lugar HH:MM',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Llegada: Lugar HH:MM',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                      ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      'Pagado: \$500.0',
                                      style: TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                TextButton.icon(
                                  icon:
                                      const Icon(Icons.remove_red_eye_outlined),
                                  label: const Text('Detalles'),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: ColorsApp.primayColor,
                                      minimumSize: const Size(150, 40)),
                                ),
                                TextButton.icon(
                                  icon: const Icon(Icons.star_purple500_outlined),
                                  label: const Text('4/5'),
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                      primary: Colors.white,
                                      backgroundColor: ColorsApp.muted,
                                      minimumSize: const Size(150, 40)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Puedes agregar más tarjetas aquí si es necesario
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
