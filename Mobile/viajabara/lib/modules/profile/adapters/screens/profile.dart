import 'package:flutter/material.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Perfil',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        foregroundColor: ColorsApp.muted,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
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
                          radius: 60,
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

                        const Row(
                          children: [
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '89',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Viajes realizados',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(
                                  '23',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  'Último mes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Divider(color: ColorsApp.text)),

                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Cambiar contraseña',
                            style: TextStyle(
                                color: ColorsApp.primayColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Editar foto de perfil',
                            style: TextStyle(
                                color: ColorsApp.primayColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          alignment: Alignment.centerLeft,
                          child: const Text(
                            'Modificar tu información personal',
                            style: TextStyle(
                                color: ColorsApp.primayColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: const Divider(color: ColorsApp.text)),

                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.email,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'vanessa987@gmail.com',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '7776788767',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.cake,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '1996-06-08',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            alignment: Alignment.centerLeft,
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.female,
                                  color: ColorsApp.text,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Mujer',
                                  style: TextStyle(color: ColorsApp.text),
                                ),
                              ],
                            )),
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
