import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';
import 'package:viajabara/modules/history/adapters/screens/historyStars.dart';

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
            ListView.builder(
                itemCount:
                    6, 
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.location_on, size: 20.0),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Origen',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: ColorsApp.text,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Text("ViajaBara",
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        color: ColorsApp.text,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Row(
                                  children: [
                                    Icon(CupertinoIcons.compass_fill,
                                        size: 20.0),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text('Destino',
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            color: ColorsApp.text,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ]),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Divider(
                            color: ColorsApp.text,
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 1, horizontal: 15),
                            height: 70.0,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        'Morelos',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: ColorsApp.text,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 15),
                                        child: SvgPicture.asset(
                                            StuffApp.logoViajabara,
                                            height: 15,
                                            width: 15),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          'Guadalajara',
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: ColorsApp.text,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      '8:30 a.m',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: ColorsApp.text,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        '08/08/2022',
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: ColorsApp.text,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '12:30 p.m',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: ColorsApp.text,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
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
                                      size: 20,
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Detalles',
                                      style: TextStyle(fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
