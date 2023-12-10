import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/domain/entities/qualifications/qualifications.dart';
import 'package:viajabara/domain/entities/trip/driver_trip.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/custom_progress_indicator.dart';
import 'package:viajabara/providers/driver_provider.dart';
import 'package:viajabara/providers/utils/utils.dart';

class HistoryStars extends StatefulWidget {
  final DriverTrip trip;
  const HistoryStars({Key? key, required this.trip}) : super(key: key);

  @override
  State<HistoryStars> createState() => _HistoryStarsState();
}

class _HistoryStarsState extends State<HistoryStars> {
  Future<List<Qualifications>> data = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var tripsData = await DriverProvider().getQualificationsAboutTravel(widget.trip.id!);
    setState(() {
      data = Future.value(tripsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    String? salida = "${widget.trip.trip?.route?.startAddress?.description}-${widget.trip.startDate}-${widget.trip.trip?.startTime}";
    String? horaLlegada = Utils().sumarTiempo(widget.trip.trip!.startTime!, widget.trip.trip!.route!.time!);
    String? llegada = "${widget.trip.trip?.route?.endAddress?.description}-${widget.trip.startDate}-$horaLlegada";
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Comentarios',
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
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      height: 90.0,
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Alinear a la izquierda
                        mainAxisAlignment:
                            MainAxisAlignment.spaceAround, // Espaciado uniforme
                        children: <Widget>[
                          Text('Salida : $salida',
                              style: const TextStyle(fontSize: 15.0)),
                          Text('Llegada : $llegada',
                              style: const TextStyle(fontSize: 15.0)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  FutureBuilder<List<Qualifications>>(
                    future: data,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomCircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return Text('No hay comentarios disponibles aún');
                      } else {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return comentarioWidget(snapshot.data![index]);
                          },
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget comentarioWidget(Qualifications qualification) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.transparent,
              child: SvgPicture.string(
                  utf8.decode(base64.decode(qualification.clientPhoto!))),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Calificación: ${qualification.score.toString()}"),
                      const Icon(Icons.star, color: Colors.yellow),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                      "Comentarios: ${qualification.comments ?? 'Sin comentarios'}"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
