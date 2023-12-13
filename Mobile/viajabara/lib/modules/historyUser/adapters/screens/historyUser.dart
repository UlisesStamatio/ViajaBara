import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:viajabara/domain/entities/user/user_history_trips.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/kernel/widgets/details/details_history_client.dart';
import 'package:viajabara/kernel/widgets/details/details_travels.dart';
import 'package:viajabara/kernel/widgets/historyUser/qualify_driver.dart';
import 'package:viajabara/modules/historyUser/adapters/screens/traveling.dart';
import 'package:viajabara/providers/client_provider.dart';
import 'package:viajabara/providers/utils/utils.dart';

class HistoryUser extends StatefulWidget {
  const HistoryUser({Key? key}) : super(key: key);

  @override
  State<HistoryUser> createState() => _HistoryUserState();
}

class _HistoryUserState extends State<HistoryUser> {
  Future<List<HistoryClientTrip>> data = Future.value([]);

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var historyData = await ClientProvider().getHistoryTrips();
    setState(() {
      data = Future.value(historyData);
    });
  }

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
            FutureBuilder<List<HistoryClientTrip>>(
              future: data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      loadData();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: const <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: Center(
                              child: Text('No hay historial disponible',
                                  style: TextStyle(fontSize: 20))),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    loadData();
                  },
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return _buildHistoryCard(snapshot.data![index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryCard(HistoryClientTrip history) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 45,
                  backgroundColor: Colors.transparent,
                  child: Utils().profilePicture(history.profileImageDriver!),
                ),
                const SizedBox(width: 20.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Salida: ${history.startAddress?.state}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Llegada: ${history.endAddress?.state}',
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Pagado: \$${history.cost}0 ',
                        style: const TextStyle(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton.icon(
                    icon: const Icon(Icons.remove_red_eye_outlined),
                    label: const Text('Detalles'),
                    onPressed: () {
                      _showModalInfo(context, history);
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: ColorsApp.primayColor,
                        minimumSize: const Size(120, 40)),
                  ),
                  history.stateTrip == 3
                      ? TextButton.icon(
                          icon: const Icon(Icons.thumb_up),
                          label: const Text('Calificar'),
                          onPressed: () {
                            _qualifyDriver(context, history);
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: ColorsApp.primayColor,
                              minimumSize: const Size(120, 40)),
                        )
                      : TextButton.icon(
                          icon: const Icon(CupertinoIcons.map_fill),
                          label: const Text('Ver viaje'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TravelingUser(trip: history)));
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: ColorsApp.primayColor,
                              minimumSize: const Size(150, 40)),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _qualifyDriver(BuildContext context, HistoryClientTrip trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return QualifyDriver(historyClientTrip: trip);
      },
    );
  }

  void _showModalInfo(BuildContext context, HistoryClientTrip trip) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (BuildContext context) {
        return DetailsHistoryClient(trip: trip);
      },
    );
  }
}
