import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:viajabara/kernel/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

class HistoryUser extends StatefulWidget {
  const HistoryUser({Key? key}) : super(key: key);

  @override
  State<HistoryUser> createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
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
                                backgroundImage:
                                    AssetImage('assets/images/perfilGirl.avif'),
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
                                  onPressed: () => _mostrarModal(context),
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
                                backgroundImage:
                                    AssetImage('assets/images/Girl.png'),
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
                                  icon:
                                      const Icon(Icons.star_purple500_outlined),
                                  label: const Text('4.5'),
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

  void _mostrarModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return _contenidoDelModal();
      },
    );
  }

  Widget _contenidoDelModal() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.8,
      padding: const EdgeInsets.all(20.0),
      color: Colors.transparent,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 80.0,
              backgroundImage: AssetImage('assets/images/perfilGirl.avif'),
            ),
            const SizedBox(height: 10.0),
            const Text('Nathaly Escalona', style: TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0),
            const Text('¿Qué te ha parecido el viaje?',
                style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 10.0),
            const Text('Calificación',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            const SizedBox(height: 20.0),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comentarios',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.arrow_forward_ios_outlined),
                  label: const Text('Omitir'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
          ],
        ),
      ),
    );
  }
}
