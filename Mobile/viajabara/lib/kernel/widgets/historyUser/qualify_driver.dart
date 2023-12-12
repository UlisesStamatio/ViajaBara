import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:viajabara/domain/entities/user/user_history_trips.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/providers/client_provider.dart';
import 'package:viajabara/providers/utils/utils.dart';

class QualifyDriver extends StatefulWidget {
  final HistoryClientTrip historyClientTrip;
  const QualifyDriver({Key? key, required this.historyClientTrip})
      : super(key: key);

  @override
  _QualifyDriver createState() => _QualifyDriver();
}

class _QualifyDriver extends State<QualifyDriver> {
  double _rating = 0;
  String _comment = '';
  bool _isButtonDisabled = true;

  void _updateButtonState() {
    setState(() {
      _isButtonDisabled = _rating <= 0 || _comment.isEmpty;
    });
  }

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
            CircleAvatar(
              radius: 80.0,
              backgroundColor: Colors.transparent,
              child: Utils()
                  .profilePicture(widget.historyClientTrip.profileImageDriver!),
            ),
            const SizedBox(height: 10.0),
            Text(widget.historyClientTrip.nameDriver!,
                style: const TextStyle(fontSize: 25.0)),
            const SizedBox(height: 10.0),
            const Text('¿Qué te ha parecido el viaje?',
                style: TextStyle(fontSize: 20.0)),
            const SizedBox(height: 10.0),
            const Text('Calificación',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10.0),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                _rating = rating;
                _updateButtonState();
              },
            ),
            const SizedBox(height: 20.0),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Comentarios',
              ),
              maxLines: 3,
              onChanged: (text) {
                _comment = text;
                _updateButtonState();
              },
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
                      foregroundColor: Colors.white,
                      backgroundColor: ColorsApp.primayColor,
                      minimumSize: const Size(150, 40)),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.thumb_up_outlined),
                  label: const Text('Calificar'),
                  onPressed: _isButtonDisabled
                      ? null
                      : () async {
                          bool result = await ClientProvider()
                              .registerQualification(
                                  widget.historyClientTrip.id!,
                                  _rating,
                                  _comment);

                          if (result) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Se agrego correctamente la calificación')),
                            );
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'No se pudo agregar la calificación')),
                            );
                            Navigator.of(context).pop();
                          }
                        },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
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
