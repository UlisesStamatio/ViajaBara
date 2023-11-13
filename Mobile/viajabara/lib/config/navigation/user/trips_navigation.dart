import 'package:flutter/material.dart';
import 'package:viajabara/modules/tripsUser/adapters/screens/booking.dart';
import 'package:viajabara/modules/tripsUser/adapters/screens/payment.dart';
import 'package:viajabara/modules/tripsUser/adapters/screens/trip.dart';

class TripsNavigation extends StatelessWidget {
  const TripsNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/trip',
      routes: {
        '/trip': (context) => const Trip(),
        '/booking': (context) => const Booking(),
        '/pay': (context) => const Payment(),
      },
    );
  }
}
