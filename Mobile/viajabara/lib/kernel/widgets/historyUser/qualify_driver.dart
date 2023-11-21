import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';

class QualifyDriver extends StatefulWidget {
  const QualifyDriver({Key? key}) : super(key: key);

  @override
  _QualifyDriver createState() => _QualifyDriver();
}

class _QualifyDriver extends State<QualifyDriver> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.73,
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
