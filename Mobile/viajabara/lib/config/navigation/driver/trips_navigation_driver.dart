import 'package:flutter/material.dart';
import 'package:viajabara/modules/trips/adapters/screens/traveling.dart';
import 'package:viajabara/modules/trips/adapters/screens/trips.dart';

class TripsNavigationDriver extends StatelessWidget {
  const TripsNavigationDriver({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/trips',
      routes: {
        '/trips': (context) => const Trips(),
        "/traveling": (context) => const Traveling(),
      },
    );
  }
}
