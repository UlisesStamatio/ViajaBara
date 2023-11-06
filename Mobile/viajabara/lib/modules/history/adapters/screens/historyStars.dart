import 'package:flutter/material.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class HistoryStars extends StatelessWidget {
  const HistoryStars({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Comentarios',
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsApp.primayColor),
          onPressed: () {
            Navigator.of(context).pop(); // Regresar a la página anterior
          },
        ),
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
                  Card(
                    elevation: 5,
                    margin: const EdgeInsets.only(top: 20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      height: 80.0,
                      child: const Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Alinear a la izquierda
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly, // Espaciado uniforme
                        children: <Widget>[
                          Text('Salida : Lugar YYYY/mm/dd HH:MM',
                              style: TextStyle(fontSize: 17.0)),
                          Text('Llegada : Lugar YYYY/mm/dd HH:MM',
                              style: TextStyle(fontSize: 17.0)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                      height:
                          16.0), // Espacio entre la tarjeta y las calificaciones
                  comentarioWidget(),
                  comentarioWidget(),
                  comentarioWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comentarioWidget() {
    return const Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 30, // puedes ajustar el tamaño de la imagen redonda aquí
              backgroundImage: NetworkImage(
                  'https://cdn.icon-icons.com/icons2/1999/PNG/512/avatar_people_person_profile_student_user_icon_123383.png'), // reemplaza con la ruta de tu imagen
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.yellow),
                      Icon(Icons.star, color: Colors.grey),
                      Icon(Icons.star, color: Colors.grey),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  Text(
                      'Comentarios: Lorem ipsum Lorem ipsum Lorem ipsum Lorem ipsum'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
