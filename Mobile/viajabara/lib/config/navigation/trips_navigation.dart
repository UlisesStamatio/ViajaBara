import 'package:flutter/material.dart';
import 'package:viajabara/modules/trips/adapters/screens/trips.dart';

class TripsNavigation extends StatelessWidget {
  const TripsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/trips',
      routes: {
        '/trips': (context) => const Trips(),
      },
    );
  }
}
