import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

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
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  const SizedBox(height: 10), // Espacio entre el logo y la Card
                  Card(
                    margin: const EdgeInsets.all(16),
                    elevation: 5,
                    child: Column(
                      children: [
                        const SizedBox(
                            height:
                                20), // Espacio en la parte superior de la Card
                        const CircleAvatar(
                          radius: 90,
                          backgroundImage: AssetImage('assets/images/Girl.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Title(
                            color: ColorsApp.primayColor,
                            child: const Text(
                              'Vanessa',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                        const ListTile(
                          title: Text(
                            '89',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20, // O el tamaño que prefieras
                            ),
                          ),
                          subtitle: Text(
                            'Viajes realizados',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  18, // O el tamaño que prefieras para el subtitle
                            ),
                          ),
                        ),
                        const ListTile(
                          title: Text(
                            '23',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20, // O el tamaño que prefieras
                            ),
                          ),
                          subtitle: Text(
                            'Último mes',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  18, // O el tamaño que prefieras para el subtitle
                            ),
                          ),
                        ),

                        const Divider(),
                        const ListTile(
                          title: Text('Cambiar contraseña'),
                          textColor: ColorsApp.linksColor,
                        ),
                        const ListTile(
                          title: Text('Editar foto de perfil'),
                          textColor: ColorsApp.linksColor,
                        ),
                        const ListTile(
                          title: Text('Modificar tu información personal'),
                          textColor: ColorsApp.linksColor,
                        ),
                        const Divider(),
                        const ListTile(
                          leading: Icon(Icons.email),
                          title: Text('vanessa987@gmail.com'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.phone),
                          title: Text('7776788767'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.calendar_today),
                          title: Text('08/06/1998'),
                        ),
                        const ListTile(
                          leading: Icon(Icons.female),
                          title: Text('Mujer'),
                        ),
                        const SizedBox(
                            height:
                                20), // Espacio en la parte inferior de la Card
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
