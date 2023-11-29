import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:viajabara/kernel/themes/colors/colors_app.dart';
import 'package:viajabara/kernel/themes/stuff.dart';

class Passengers extends StatefulWidget {
  const Passengers({super.key});

  @override
  State<Passengers> createState() => _PassengersState();
}

class _PassengersState extends State<Passengers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Viajar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        vertical: 15.0, horizontal: 16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Align(
                                alignment: Alignment.center,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      'assets/images/perfilGirl.avif'),
                                ),
                              ),
                              const SizedBox(width: 20.0),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: ColorsApp.dangerColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Luis Miguel",
                                        style: TextStyle(
                                            color: ColorsApp.blackColor,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 10.0),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Row(
                                    children: [
                                      Icon(
                                        Icons.place,
                                        color: ColorsApp.dangerColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Paloma de la Paz",
                                        style: TextStyle(
                                            color: ColorsApp.blackColor,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 10.0),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.clock,
                                        color: ColorsApp.dangerColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "8:30 a.m.",
                                        style: TextStyle(
                                            color: ColorsApp.blackColor,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 10.0),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: const Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.compass,
                                        color: ColorsApp.dangerColor,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Ciudad de México, Chapultepec",
                                        style: TextStyle(
                                            color: ColorsApp.blackColor,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: 5.0),
                            ],
                          ),
                          Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: const Divider(color: ColorsApp.text)),
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                const Align(
                                    alignment: Alignment.center,
                                    child: Text("¿Asistio?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape:
                                                const CircleBorder(), // Forma circular
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {},
                                          child: const Icon(Icons.check),
                                        ),
                                        const SizedBox(width: 5.0),
                                      ],
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        const SizedBox(width: 15.0),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: const EdgeInsets.all(20),
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {},
                                          child: const Icon(Icons.cancel),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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
