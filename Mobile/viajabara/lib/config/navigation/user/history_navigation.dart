import 'package:flutter/material.dart';
import 'package:viajabara/modules/historyUser/adapters/screens/historyUser.dart';

class HistoryNavigation extends StatelessWidget {
  const HistoryNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/history',
      routes: {
        '/history': (context) => const HistoryUser(),
      },
    );
  }
}
